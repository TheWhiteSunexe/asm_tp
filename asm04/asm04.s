section .bss
    buffer resb 4

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 4
    syscall

    ; On converti d'ascii en entier
    mov al, [buffer]
    sub al, '0'

    ; on teste le bit faible
    test al, 1
    jnz odd

    ; Si c'est pair alors sortie sans erreurs
    mov rax, 60
    mov rdi, 0
    syscall

odd:
    ; Si c'est impair alors sortie avec erreur
    mov rax, 60
    mov rdi, 1
    syscall
