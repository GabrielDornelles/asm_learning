echo "Compiling $1"
nasm -f elf64 -o $1.o $1.asm
ld $1.o -o $1
echo "Executing ./$1"
./$1