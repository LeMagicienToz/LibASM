bits 64 ;commentaire 

section .data

section .bss

section .text
	global ft_strcpy

ft_strcpy:
	mov rax, rdi
strcpy_loop:
	mov dl, byte [rsi]    ; Charger le caractère de la chaîne pointée par rdi dans al
    mov byte [rdi], dl    ; Charger le caractère de la chaîne pointée par rsi dans bl
	test dl, dl
	jz strcpy_end			; si == 0 (donc fin de la chaine de caracatere )
	inc rdi					;increment char next
	inc rsi					;increment char next
	jmp strcpy_loop			;recursive

strcpy_end :
	ret
