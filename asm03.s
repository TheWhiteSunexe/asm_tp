section .data
    msg db "1337", 10

section .text
    global _start

_start:
    ; est-ce supérieur à 2 ?
    mov rax, [rsp]
    cmp rax, 2
    jne fail

    ; La on récupère argv[1]
    mov rbx, [rsp + 16]

    ; On vient vérifier si on a "42"
    mov al, [rbx]
    cmp al, '4'
    jne fail

    mov al, [rbx + 1]
    cmp al, '2'
    jne fail

    mov al, [rbx + 2]
    cmp al, 0
    jne fail

    ; Dans ce cas on affiche le msg
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 5
    syscall

    ; Cas sans erreurs
    mov rax, 60
    mov rdi, 0
    syscall

fail:
    ; Cas avec erreurs
    mov rax, 60
    mov rdi, 1
    syscall
