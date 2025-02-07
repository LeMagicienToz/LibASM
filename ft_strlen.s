bits 64 ;commentaire 

section .data

section .bss

section .text
	global ft_strlen

ft_strlen:
    xor rax, rax   
strlen_loop:
    mov bl, byte [rdi] ; Load next byte

    test bl, bl ; Jump to end if end of string
    jz strlen_end

    inc rdi ; Move pointer to next byte
    inc rax ; Increment len of string
    jmp strlen_loop

strlen_end :
	ret
