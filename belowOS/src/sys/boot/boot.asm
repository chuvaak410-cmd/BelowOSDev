MB_MAGIC    equ 0x1BADB002
MB_FLAGS    equ 0x00000003 ; ALIGN + MEMINFO
MB_CHECKSUM equ -(MB_MAGIC + MB_FLAGS)

section .multiboot
align 4
    dd MB_MAGIC
    dd MB_FLAGS
    dd MB_CHECKSUM

section .text
bits 32
global start
extern OSmain

start:
    cli
    mov esp, stack_top
    call OSmain
.hlt:
    hlt
    jmp .hlt

section .bss
align 16
stack_bottom:
    resb 16384
stack_top: