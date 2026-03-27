typedef __SIZE_TYPE__ size_t;
#define NULL ((void*)0)

// ==========================================
// Memory Management (malloc, free)
// ==========================================

typedef struct Block {
    size_t size;
    int is_free;
    struct Block* next;
} Block;

static Block* free_list = NULL;
// Simple 2MB static heap for memory allocation
static unsigned char heap_space[2 * 1024 * 1024]; 
static int heap_initialized = 0;

void malloc_init() {
    free_list = (Block*)heap_space;
    free_list->size = sizeof(heap_space) - sizeof(Block);
    free_list->is_free = 1;
    free_list->next = NULL;
    heap_initialized = 1;
}

void* malloc(size_t size) {
    if (!heap_initialized) malloc_init();
    
    // Align to 8 bytes boundary
    size = (size + 7) & ~7;
    
    Block* curr = free_list;
    while (curr) {
        if (curr->is_free && curr->size >= size) {
            // Split the block if it has enough remaining space
            if (curr->size > size + sizeof(Block) + 16) {
                Block* new_block = (Block*)((unsigned char*)curr + sizeof(Block) + size);
                new_block->size = curr->size - size - sizeof(Block);
                new_block->is_free = 1;
                new_block->next = curr->next;
                
                curr->size = size;
                curr->is_free = 0;
                curr->next = new_block;
            } else {
                curr->is_free = 0;
            }
            return (void*)((unsigned char*)curr + sizeof(Block));
        }
        curr = curr->next;
    }
    return NULL; // Out of memory
}

void free(void* ptr) {
    if (!ptr) return;
    
    Block* block = (Block*)((unsigned char*)ptr - sizeof(Block));
    block->is_free = 1;
    
    // Coalesce adjacent free blocks
    Block* curr = free_list;
    while (curr) {
        if (curr->is_free && curr->next && curr->next->is_free) {
            curr->size += sizeof(Block) + curr->next->size;
            curr->next = curr->next->next;
        } else {
            curr = curr->next;
        }
    }
}

// ==========================================
// Standard String and Memory functions
// ==========================================

void* memcpy(void* dest, const void* src, size_t n) {
    unsigned char* d = (unsigned char*)dest;
    const unsigned char* s = (const unsigned char*)src;
    while (n--) {
        *d++ = *s++;
    }
    return dest;
}

// D compiler might define its own memset in header.d, 
// using a different name to avoid duplicate symbol errors if needed
void* memset_c(void* s, int c, size_t n) {
    unsigned char* p = (unsigned char*)s;
    while (n--) *p++ = (unsigned char)c;
    return s;
}

size_t strlen(const char* s) {
    size_t len = 0;
    while (s[len]) len++;
    return len;
}

int strcmp(const char* s1, const char* s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(unsigned char*)s1 - *(unsigned char*)s2;
}


// ==========================================
// I/O Operations (printf)
// ==========================================

// Built-in attributes for reading variadic arguments
typedef __builtin_va_list va_list;
#define va_start(v, l) __builtin_va_start(v, l)
#define va_end(v)      __builtin_va_end(v)
#define va_arg(v, l)   __builtin_va_arg(v, l)

// Connect to BelowOS VGA driver elements exported by D (header.d)
extern int curX;
extern int curY;
extern unsigned short* vram;
extern void scroll(void);

void putchar(char c) {
    if (c == '\n') {
        curX = 0;
        curY++;
    } else if (c == '\t') {
        curX += 4;
    } else {
        // Foreground White (0x0F)
        if (vram) {
            vram[curY * 80 + curX] = (0x0F << 8) | (unsigned char)c;
        }
        curX++;
    }
    
    if (curX >= 80) { curX = 0; curY++; }
    if (curY >= 25) { 
        if (&scroll) scroll(); 
    }
}

int printf(const char* fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int written = 0;
    
    while (*fmt) {
        if (*fmt == '%' && *(fmt + 1)) {
            fmt++;
            if (*fmt == 'd') {
                int val = va_arg(args, int);
                if (val < 0) {
                    putchar('-');
                    written++;
                    val = -val;
                }
                if (val == 0) {
                    putchar('0');
                    written++;
                } else {
                    char buf[12];
                    int i = 0;
                    while (val > 0) {
                        buf[i++] = (val % 10) + '0';
                        val /= 10;
                    }
                    while (i > 0) {
                        putchar(buf[--i]);
                        written++;
                    }
                }
            } else if (*fmt == 's') {
                const char* s = va_arg(args, const char*);
                if (!s) s = "(null)";
                while (*s) {
                    putchar(*s++);
                    written++;
                }
            } else if (*fmt == 'x') {
                unsigned int val = va_arg(args, unsigned int);
                if (val == 0) {
                    putchar('0');
                    written++;
                } else {
                    char buf[12];
                    int i = 0;
                    while (val > 0) {
                        int rem = val % 16;
                        buf[i++] = (rem < 10) ? (rem + '0') : (rem - 10 + 'a');
                        val /= 16;
                    }
                    while (i > 0) {
                        putchar(buf[--i]);
                        written++;
                    }
                }
            } else if (*fmt == 'c') {
                int c = va_arg(args, int);
                putchar((char)c);
                written++;
            } else if (*fmt == '%') {
                putchar('%');
                written++;
            }
        } else {
            putchar(*fmt);
            written++;
        }
        fmt++;
    }
    
    va_end(args);
    return written;
}
