section .data
    msg db "1337", 10   ; 10 = \n

section .text
    global _start

_start:
    ; write(stdout, msg, 5)
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 5   
    syscall

    ; exit(0)
    mov rax, 60
    mov rdi, 0
    syscall
