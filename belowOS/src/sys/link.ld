ENTRY(start)

SECTIONS {
    /* Начинаем с 1 МБ */
    . = 1M;

    /* Код программы */
    .text BLOCK(4K) : ALIGN(4K) {
        /* Multiboot заголовок должен быть в первых 8КБ файла */
        KEEP(*( .multiboot )) 
        *(.text)
        *(.text.*)
    }

    /* Только для чтения (константы, строки из Zig/D) */
    .rodata BLOCK(4K) : ALIGN(4K) {
        *(.rodata*)
    }

    /* Инициализированные данные */
    .data BLOCK(4K) : ALIGN(4K) {
        *(.data*)
    }

    /* Неинициализированные данные (стек, глобальные переменные) */
    .bss BLOCK(4K) : ALIGN(4K) {
        *(COMMON)
        *(.bss*)
    }

    /* Удаляем мусор, который генерируют компиляторы (Zig/D/GCC) */
    /DISCARD/ : {
        *(.comment)
        *(.eh_frame)
        *(.note.*)
    }
}