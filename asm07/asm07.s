section .bss
    buffer resb 4

section .text
    global _start

_start:
    ; On lit l'entrée
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 4
    syscall

    ; On transforme en entier
    movzx r8, byte [buffer]
    sub r8, '0'
    cmp r8, 2
    jl not_prime
    mov r9, 2

check_loop:
    cmp r9, r8
    jge prime
    mov rax, r8
    xor rdx, rdx
    div r9
    cmp rdx, 0
    je not_prime
    inc r9
    jmp check_loop

prime:
    mov rax, 60
    xor rdi, rdi
    syscall

not_prime:
    mov rax, 60
    mov rdi, 1
    syscall
