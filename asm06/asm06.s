section .bss
    result resb 16

section .text
    global _start

_start:
    ; est-ce que argc == 3 ?
    mov rax, [rsp]
    cmp rax, 3
    jne fail

    ; partie pour argv[1]
    mov rsi, [rsp + 16]
    call atoi
    mov r8, rax

    ; partie pour argv[2]
    mov rsi, [rsp + 24]
    call atoi

    ; addition des deux
    add rax, r8

    ; on converti en chaine
    mov rdi, result
    call itoa

    ; longueur
    mov rdx, rax

    ; puis on fait l'affichage
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    ; sortie sans erreur
    mov rax, 60
    xor rdi, rdi
    syscall

fail:
    mov rax, 60
    mov rdi, 1
    syscall

atoi:
    xor rax, rax

atoi_loop:
    mov bl, [rsi]
    cmp bl, 0
    je atoi_done

    sub bl, '0'
    imul rax, 10
    add rax, rbx

    inc rsi
    jmp atoi_loop

atoi_done:
    ret
itoa:
    mov rcx, 10
    xor r8, r8

itoa_loop:
    xor rdx, rdx
    div rcx

    add dl, '0'
    push rdx

    inc r8
    test rax, rax
    jnz itoa_loop

    mov rcx, r8

write_digits:
    pop rax
    mov [rdi], al
    inc rdi
    loop write_digits

    mov rax, r8
    ret

section .data
    nl db 10
