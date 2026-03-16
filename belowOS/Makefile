# Флаги для Zig: 32-битный режим, без стандартной библиотеки, без проверок стека
ZIG_FLAGS = -target x86-freestanding-none -fno-stack-check -O ReleaseSafe

all:
	@mkdir -p build
	# 1. Ассемблер
	nasm -f elf32 src/sys/boot/boot.asm -o build/boot.o
	
	# 2. Zig (компилируем в объектный файл)
	zig build-obj zig_src/ext2.zig -target x86-freestanding-none -fno-stack-check -O ReleaseSafe -femit-bin=build/ext2_zig.o
	
	# 3. D (BetterC)
	ldc2 -betterC -boundscheck=off -c -mtriple=i386-pc-linux-gnu src/sys/boot/kernel/header.d -of=build/kernel.o
	ldc2 -betterC -boundscheck=off -c -mtriple=i386-pc-linux-gnu src/sys/boot/kernel/ext2.d -of=build/ext2_d.o
	
	# 4. Линковка (добавляем новые .o файлы)
	ld -m elf_i386 --no-warn-rwx-segments -z noexecstack -T src/sys/link.ld \
		build/boot.o \
		build/kernel.o \
		build/ext2_d.o \
		build/ext2_zig.o \
		-o build/myos.elf

run: all
	@if [ ! -f hdd.img ]; then qemu-img create -f raw hdd.img 10M; fi
	qemu-system-i386 -kernel build/myos.elf -drive file=hdd.img,format=raw,index=0,media=disk -vga std

clean:
	rm -rf build