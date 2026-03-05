ENTRY(start)

SECTIONS {
    . = 1M; /* Начинаем с 1 МБ */

    .text : {
        /* Принудительно вставляем Multiboot в самое начало файла */
        KEEP(*( .multiboot )) 
        *(.text)
        *(.text.*)
    }

    .rodata : { *(.rodata*) }
    .data   : { *(.data*) }
    .bss    : { 
        *(COMMON)
        *(.bss*) 
    }

    /DISCARD/ : {
        *(.comment)
        *(.eh_frame)
    }
}