bits 64 ;commentaire 

section .data

section .bss
    len resq 1

section .text
	extern __errno_location
	global ft_write

ft_write:
	test rsi, rsi          ; Vérifier si buf (rsi) est NULL
    jz error_einval        ; Sauter à l'erreur si NULL
	mov rax, 0x01 ;SYS_WRITE 0x01 (same as 1)
	syscall ;call system for write
	test rax, rax; cmp rax < 0
	js errno ; jump si negatif 
	ret

errno:
	neg rax    ; get absolute value of syscall return (-13 -> 13)
	push rax; stock 13 dans la stack
	call __errno_location wrt ..plt ;push dans rax l'address de errno 
	pop qword [rax] ; set errno avec la valeur 13(le push avant)
    mov rax, -1
    ret

error_einval:
	mov edi, 22             ; Préparer EINVAL (22)(argument invalide ) en argument pour __errno_location   edi est le 1er argument d'une fonction en x86-64 System V ABI.
    call __errno_location wrt ..plt   ; Récupérer l'adresse de errno
    mov [rax], dword edi    ; Stocker EINVAL (22) dans errno
    mov rax, -1             ; Retourner -1
    ret