all:
	@mkdir -p build
	nasm -f elf32 sys/boot/boot.asm -o build/boot.o
	ldc2 -betterC -boundscheck=off -c -mtriple=i386-pc-linux-gnu sys/boot/kernel/header.d -of=build/kernel.o
	ld -m elf_i386 --no-warn-rwx-segments -z noexecstack -T sys/link.ld build/boot.o build/kernel.o -o build/myos.elf

run: all
	@if [ ! -f hdd.img ]; then qemu-img create -f raw hdd.img 10M; fi
	qemu-system-i386 -kernel build/myos.elf -drive file=hdd.img,format=raw,index=0,media=disk -vga std