## Compile
```sh
nasm -f elf64 -o hello.o hello.asm
ld hello.o -o hello
./hello
```

Registers are part of the processor that temporarly holds memory. So registers can hold values (like ints, chars etc).
in x86_64 architechture registers are 64 bit (but theres also 32,16 and 8 bit registers).

- General-purpose registers (might be used with any instructions doing computation with general purpose ):
    - rax, rbx, rcx, rdx, rsi, rdi, rbp, rsp, r8, r9, r10, r11, r12, r13, r14, r15
A syscall is when the program requests a service from the kernel.

Here are the registers in order for System Call:

---
1. **RAX**: holds the ID for the syscall (syscalls: https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl)


2. **RDI**: holds the file descriptor (0 is std input, 1 is std output, 2 is std error)


3. **RSI**: holds the buffer (location of message itself), which can be passed like text db 'string message'. Where db is Define Bytes.


4. **RDX**: length of the buffer

---

![image](https://user-images.githubusercontent.com/56324869/209419967-d801fd19-ffa4-4d81-8ff6-a1e851a867dc.png)

![image](https://user-images.githubusercontent.com/56324869/209420122-cbef30dc-3730-4677-b6dc-e9529b721907.png)

after using **CMP** to compare, flags are set.

![image](https://user-images.githubusercontent.com/56324869/209420433-e0fd1d1e-1acc-4642-b380-92f1acb1bd33.png)

**call** have **ret** and it returns to the original position where a call was made.

a **jmp** on the other side simply jump to some location and doesnt return.

**resb** is reserve bytes, followed by how many bytes it should reserve


![image](https://user-images.githubusercontent.com/56324869/209421517-b354d891-bccf-448f-90af-db12b44e3f32.png)


**al** Holds the least significant byte of **rax**

```
EAX is the full 32-bit value
AX is the lower 16-bits
AL is the lower 8 bits
AH is the bits 8 through 15 (zero-based)
```


## Stack operations

- **push** register/value ; pushes the value onto the stack (push 4)
- **pop** register ; pop the value from the stack and stores it in the register, can also pop it directly at a pointer like pop [label]
- **mov** register, [rsp] ; stores the peek value in register (rsp is the Stack Pointer)

## Macros

Example (no args):
```asm
%macro exit 0
    mov rax, 60
    mov rdi,0
    syscall
%endmacro
```

Example (1 arg):
```asm
%macro printDigit 1
    mov rax, %1
    call _printRAXDigit
%endmacro

_start:

    printDigit 3
    printDigit 4
    exit
```

Example (2 args):
```asm
%macro printDigitSum 2
    mov rax, %1
    add rax, %2
    call _printRAXDigit
%endmacro

_start:
    printDigitSum 3, 2
    exit
```

If you are defining **labels** inside your **macro**, it can only be expanded once by the compiler. Because of it, labels cant be called more than **once** in the macro, to be able to call it more times, define it with **%%**:

### Not good:
```asm
%macro freeze 0
_loop:
    jmp _loop
%endmacro
```

### Good:
```asm
%macro freeze 0
%%loop:
    jmp %%loop
%endmacro
```

## Defining Values with EQU

You can define constants with **equ** keyword.

Example:

```asm
STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_READ equ 0 
SYS_WRITE equ 1
SYS_EXIT equ 60

_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    ...
    syscall

    mov rax, SYS_EXIT
    mov rdi 0
    syscall
```

## Includes

Include other assembly programs with
```asm
%include "filename.asm"
```

Example (linunx64.inc: https://pastebin.com/N1ZdmhLw):
```asm
%include "linux64.inc"

section .data
    text db "hello, World!", 10, 0

section .text 
    global _start

_start:
    print text
    exit
```