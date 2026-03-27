
ZIG_FLAGS = -target x86-freestanding-none -fno-stack-check -O ReleaseSafe

D_INCLUDE = -Isrc/sys/boot/kernel

all:
	@mkdir -p build
	# 1. Ассемблер (Теперь используется FASM)
	# Флаг format ELF внутри исходника или использование fasm напрямую
	fasm src/sys/boot/boot.asm build/boot.o
	
	# 2. Zig
	zig build-obj zig_src/ext2.zig $(ZIG_FLAGS) -femit-bin=build/ext2_zig.o
	
	# 3. D (BetterC)
	ldc2 -betterC -boundscheck=off -c -mtriple=i386-pc-linux-gnu $(D_INCLUDE) src/sys/boot/kernel/header.d -of=build/kernel.o
	ldc2 -betterC -boundscheck=off -c -mtriple=i386-pc-linux-gnu $(D_INCLUDE) src/sys/boot/kernel/ext2.d -of=build/ext2_d.o
	
	# 4. C (через zig cc)
	zig cc -target x86-freestanding -ffreestanding -fno-builtin \
		-fno-stack-protector -fno-sanitize=all -c c_cxx_src/extern.c -o build/extern_c.o
	
	# 5. Линковка
	ld -m elf_i386 --no-warn-rwx-segments -z noexecstack -T src/sys/link.ld \
		build/boot.o \
		build/kernel.o \
		build/ext2_d.o \
		build/ext2_zig.o \
		build/extern_c.o \
		-o build/myos.elf

run: all
	@if [ ! -f hdd.img ]; then qemu-img create -f raw hdd.img 10M; fi
	qemu-system-i386 -kernel build/myos.elf -drive file=hdd.img,format=raw,index=0,media=disk -vga std

clean:
	rm -rf build