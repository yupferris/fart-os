all: boot.bin

install:
	dd if=boot.bin bs=512 of=/dev/sdb

test: pad boot.bin
	qemu-system-i386 boot.bin

boot.bin: pad boot-raw.bin
	./pad boot-raw.bin boot.bin

boot-raw.bin: boot.asm
	nasm $(ASFLAGS) -o boot-raw.bin boot.asm

pad:
	clang -o pad pad.c

clean:
	rm boot.bin boot-raw.bin pad
