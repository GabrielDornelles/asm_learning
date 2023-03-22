; Find the '0' char in runtime to define the string length
section .data
    text db "Hello! I'm printing without writing manually to rsi!",10,0
    text2 db "I can also be used to find first appearence of a value in an array!",10,0

section .text
    global _start
 
_start:
    mov rax, text
    call _print
    mov rax, text2
    call _print
 
    mov rax, 60
    mov rdi, 0
    syscall
 
 
;input: rax as pointer to string
;output: print string at rax
_print:
    push rax ; push rax into the stack
    mov rbx, 0 ; write 0 at rbx register (starts our counter)

; since we didnt return (ret) from the above subroutine, below lines keep executing
_printLoop:
    inc rax ; increment rax
    inc rbx ; increment rbx (counts the string length)
    mov cl, [rax] ; move pointer of rax to cl (which we increment every iteration)
    cmp cl, 0 ; compare cl with 0 (if the current value in pointer position is 0)
    jne _printLoop ; Jump Not Equal if above cmp was not satisfied (loop again)
    
    mov rax, 1 ; (1) write syscall
    mov rdi, 1 ; (1) std output
    pop rsi ; we pushed rax pointer into the stack (which pointed to the start of the string). Pop it back to rsi
    mov rdx, rbx ; rdx receives content length in rsi (we pass rbx, which counted string length)
    syscall ; end syscall
    ret ; return to _start