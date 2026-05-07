section .bss
    buffer resb 64

section .data
    hexchars db "0123456789ABCDEF"
    nl db 10

section .text
    global _start

_start:
    mov rax, [rsp]

    cmp rax, 2
    je hex_mode
    cmp rax, 3
    je check_binary

    jmp fail
hex_mode:
    mov rsi, [rsp + 16]
    call atoi
    mov rbx, 16
    jmp convert

check_binary:
    mov rsi, [rsp + 16]

    cmp byte [rsi], '-'
    jne fail
    cmp byte [rsi + 1], 'b'
    jne fail
    cmp byte [rsi + 2], 0
    jne fail
    mov rsi, [rsp + 24]
    call atoi

    mov rbx, 2

convert:
    mov rdi, buffer
    xor r8, r8

convert_loop:
    xor rdx, rdx
    div rbx
    mov dl, [hexchars + rdx]
    push rdx
    inc r8
    test rax, rax
    jnz convert_loop

print_loop:
    pop rax
    mov [rdi], al
    inc rdi
    dec r8
    jnz print_loop
    mov rdx, rdi
    sub rdx, buffer
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall
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
