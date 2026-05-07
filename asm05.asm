section .text
    global _start

_start:
    ; est-ce que argc est sup a 2
    mov rax, [rsp]
    cmp rax, 2
    jl fail

    ; argv[1]
    mov rsi, [rsp + 16]

    ; calcul de la longueur de la chaîne
    xor rdx, rdx

count:
    cmp byte [rsi + rdx], 0
    je print
    inc rdx
    jmp count

print:
    ; On vient ecrire
    mov rax, 1
    mov rdi, 1
    syscall

    ; Nouveauté
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    ; Sortie sans erreur 
    mov rax, 60
    mov rdi, 0
    syscall

fail:
    mov rax, 60
    mov rdi, 1
    syscall

section .data
    nl db 10
