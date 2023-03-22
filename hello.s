section .data
    text db "Hello, World!Testing",10
 
section .text
    global _start
    
_start:
    call _printhello
    mov rax, 60
    mov rdi, 0
    syscall

# subroutine
_printhello:
    mov rax, 1
    mov rdi, 1
    mov rsi, text
    mov rdx, 21
    syscall
    ret
 