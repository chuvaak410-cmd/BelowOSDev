;fasm dialect
format ELF

MB_MAGIC    equ 0x1BADB002
MB_FLAGS    equ 0x00000003
MB_CHECKSUM equ -(MB_MAGIC + MB_FLAGS)

section '.multiboot' align 4
    dd MB_MAGIC
    dd MB_FLAGS
    dd MB_CHECKSUM

section '.text' executable align 4
    use32
    public start
    extrn OSmain
macro DEBUG_CHAR char {
    mov al, char
    out 0xe9, al
}
macro panic char {
    mov word [0xb8000], 0x4f00 + char 
    cli
@@: hlt
    jmp @b 
}

start:
    cli
    mov esp, stack_top
    DEBUG_CHAR 'H'
    DEBUG_CHAR 'e'
    DEBUG_CHAR 'l'
    DEBUG_CHAR 'l'
    DEBUG_CHAR 'o'
    DEBUG_CHAR '!'
    call OSmain
.hlt:
    hlt
    jmp .hlt

section '.bss' writeable align 16
    stack_bottom:
        rb 16384
    stack_top: