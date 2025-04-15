ASM=nasm
CC=gcc
LD=ld
OBJCOPY=objcopy

CFLAGS=-ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti -m32
LDFLAGS=-T linker.ld -nostdlib -m i386pe --oformat pe-i386

all: os.img

boot.bin: boot.asm
	$(ASM) -f bin boot.asm -o boot.bin

kernel.o: kernel.cpp
	$(CC) $(CFLAGS) -c kernel.cpp -o kernel.o

kernel.elf: kernel.o
	$(LD) $(LDFLAGS) kernel.o -o kernel.elf

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

os.img: boot.bin kernel.bin
	cat boot.bin kernel.bin > os.img

clean:
	rm -f *.o *.bin *.elf os.img 