section .data 
    digit db 0,10 ; 10 is the new line char

section .text
    global _start

_start:
    mov rax, 1
    ;add rax, 0
    push 1
    push 2
    push 3
    ; pushed 1 2 and 3 into the stack
    ; now pop the stack into rax (should print pushes in reverse)
    pop rax 
    call _printRAXDigit
    pop rax
    call _printRAXDigit
    pop rax
    call _printRAXDigit
    
    ; sys.exit(0)
    mov rax, 60
    mov rdi, 0
    syscall

; print RAX content as ascii subroutine
_printRAXDigit:
    add rax, 48 ; add 48 which is 1 in ascii
    mov [digit], al ;AL is the lower 8 bits of RAX register

    ; print instruction
    mov rax, 1 ; (1) write syscall
    mov rdi, 1 ; (1) std output
    mov rsi, digit ; content to display out
    mov rdx, 2 ; (2 bytes) length of content
    syscall ; end of syscall
    ret ; return from subroutine