.DEFAULT_GOAL := build

build: clean link

link: nasm
	cd build && x86_64-elf-ld -n -o kernel.bin -T ../linker.ld multiboot_header.o boot.o

nasm: src
	nasm -f elf64 -o build/multiboot_header.o src/multiboot_header.asm
	nasm -f elf64 -o build/boot.o src/boot.asm

clean:
	rm -rf build
	mkdir build