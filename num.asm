section .data 
    digit db 0,10 ; 10 is the new line char
section .text
    global _start
 
_start:
    mov rax, 1
    add rax, 1 ; adding here
    call _printRAXDigit
    
    ; sys.exit(0)
    mov rax, 60
    mov rdi, 0
    syscall

_printRAXDigit:
    add rax, 48
    mov [digit], al ;AL is the lower 8 bits of RAX register

    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall
    ret