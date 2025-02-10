bits 64 ;commentaire 

section .data

section .bss
    len resq 1

section .text
	extern __errno_location
    extern malloc
    extern ft_read
    extern ft_strcpy
    extern ft_strlen
	global ft_strdup

ft_strdup:
    mov rbx, rdi ; save src
    call ft_strlen; return dans rax la lenght 
    add rax , 1; add '\0'
    mov rdi , rax; set rdi (1er argument ) pour malloc (rdi == len maintenant )
    call malloc wrt ..plt
    test rax, rax ; gestion derreur malloc
    je error_mall
    mov rdi, rax; set le 2eme arg pour str cpy
    mov rsi, rbx ; recup la chaine source 
    call ft_strcpy
    ret

error_mall:
    ; call ft_read
    ret

; errno:
; 	neg rax    ; get absolute value of syscall return (-13 -> 13)
; 	push rax; stock 13 dans la stack
; 	call __errno_location wrt ..plt ;push dans rax l'address de errno 
; 	pop qword [rax] ; set errno avec la valeur 13(le push avant)
;     mov rax, -1
;     ret
	

