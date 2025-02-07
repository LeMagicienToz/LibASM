bits 64 ;commentaire 

section .data

section .bss

section .text
	global ft_strcpy

ft_strcpy:
strcpy_loop:
	mov al, byte [rsi]    ; Charger le caractère de la chaîne pointée par rdi dans al
    mov byte [rdi], al    ; Charger le caractère de la chaîne pointée par rsi dans bl
	test al, al
	jz strcpy_end			; si == 0 (donc fin de la chaine de caracatere )
	inc rdi					;increment char next
	inc rsi					;increment char next
	jmp strcpy_loop			;recursive

strcpy_end :
	ret
