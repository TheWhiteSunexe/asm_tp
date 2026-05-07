section .bss
    result resb 32

section .data
    nl db 10

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    jne fail
    mov rsi, [rsp + 16]
    call atoi
    mov r8, rax
    xor r9, r9
    mov rcx, 1

sum_loop:
    cmp rcx, r8
    jge done_sum
    add r9, rcx
    inc rcx
    jmp sum_loop

done_sum:
    mov rax, r9
    mov rdi, result
    call itoa
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    mov rsi, result
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
