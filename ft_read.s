bits 64 ;commentaire 

section .data

section .bss
    len resq 1

section .text
	extern __errno_location
	global ft_read

ft_read:
	mov rax, 0x00 ;SYS_READ 0x01
	syscall ;call system for READ
	test rax, rax; cmp rax < 0
	js errno
	ret

errno:
	neg rax    ; get absolute value of syscall return
	push rax; save rax to stack 
	call __errno_location wrt ..plt
	pop qword [rax] ;deref rax et repointe 1 er push du rax  
    mov rax, -1
    ret

