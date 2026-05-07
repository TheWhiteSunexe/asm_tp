section .bss
    buffer resb 4

section .data
    msg db "1337", 10

section .text
    global _start

_start:
    ; read(stdin, buffer, 4)
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 4
    syscall

    ; La on vient vérifier si c'est 42
    mov al, [buffer]
    cmp al, '4'
    jne fail

    mov al, [buffer + 1]
    cmp al, '2'
    jne fail

    ; Si c'est correct on affiche le message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 5
    syscall

    ; fin normale
    mov rax, 60
    mov rdi, 0
    syscall

fail:
    ; Si erreur
    mov rax, 60
    mov rdi, 1
    syscall
