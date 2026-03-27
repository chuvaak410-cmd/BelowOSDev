module header;
import ldc.llvmasm;
import ldc.intrinsics;
import core.stdc.stdint;

extern (C):
// Цвета текста
enum : ubyte
{
    BLACK = 0x00,
    BLUE = 0x01,
    GREEN = 0x02,
    CYAN = 0x03,
    RED = 0x04,
    MAGENTA = 0x05,
    BROWN = 0x06,
    LIGHT_GRAY = 0x07,
    DARK_GRAY = 0x08,
    LIGHT_BLUE = 0x09,
    LIGHT_GREEN = 0x0A,
    LIGHT_CYAN = 0x0B,
    LIGHT_RED = 0x0C,
    LIGHT_MAGENTA = 0x0D,
    YELLOW = 0x0E,
    WHITE = 0x0F
}
// VGA атрибут: [Фон (4 бита)][Текст (4 бита)]
ubyte Color(ubyte fg, ubyte bg = BLACK)
{
    return cast(ubyte)((bg << 4) | (fg & 0x0F));
}

void* memset(void* s, int c, size_t n)
{
    ubyte* p = cast(ubyte*) s;
    while (n--)
        *p++ = cast(ubyte) c;
    return s;
}

void __assert(const char* m, const char* f, int l)
{
    BSOD("ASSERTION_FAILED");
}
//глоб переменыые
__gshared int curX = 0;
__gshared int curY = 0;
__gshared ushort* vram = cast(ushort*) 0xB8000;
__gshared bool shiftPressed = false;
// порты
ubyte inb(ushort port)
{
    return __asm!ubyte("inb $1, $0", "={ax},N{dx}", port);
}

void outb(ushort port, ubyte val)
{
    __asm("outb %al, %dx", "{al},{dx}", val, port);
}

void outw(ushort port, ushort val)
{
    __asm("outw %ax, %dx", "{ax},{dx}", val, port);
}

ushort inw(ushort port)
{
    return __asm!ushort("inw %dx, %ax", "={ax},{dx}", port);
}
// драйвера
void scroll()
{
    for (int i = 0; i < 24 * 80; i++)
    {
        vram[i] = vram[i + 80];
    }
    for (int i = 24 * 80; i < 25 * 80; i++)
    {
        vram[i] = 0x0720;
    }
    curY = 24;
}

void OSprint(string msg, ubyte col = 0x0F)
{
    if (msg.length == 0)
        return;
    foreach (char c; msg)
    {
        if (c == '\n')
        {
            curX = 0;
            curY++;
        }
        else
        {
            vram[curY * 80 + curX] = cast(ushort)((col << 8) | c);
            curX++;
        }
        if (curX >= 80)
        {
            curX = 0;
            curY++;
        }
        if (curY >= 25)
            scroll();
    }
}
// ОБРАБОТКА КЛАВИАТУРЫ 
char get_char()
{
    static const char[128] map = [
        0, 27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
        '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
        0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', 0,
        '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, '*', 0, ' '
    ];
    static const char[128] shiftMap = [
        0, 27, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b',
        '\t', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',
        0, 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~', 0,
        '|', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', 0, '*', 0, ' '
    ];

    while (!(inb(0x64) & 1))
    {
    }
    ubyte code = inb(0x60);

    if (code == 0x2A || code == 0x36)
    {
        shiftPressed = true;
        return 0;
    }
    if (code == 0xAA || code == 0xB6)
    {
        shiftPressed = false;
        return 0;
    }
    if (code >= 0x80)
        return 0;

    return shiftPressed ? shiftMap[code] : map[code];
}

void OSinput(char* buf, int len)
{
    int i = 0;
    while (i < len - 1)
    {
        char c = get_char();
        if (c == 0)
            continue;
        if (c == '\n')
            break;
        if (c == '\b')
        {
            if (i > 0)
            {
                i--;
                curX--;
                vram[curY * 80 + curX] = 0x0720;
            }
            continue;
        }
        buf[i++] = c;
        char[1] s;
        s[0] = c;
        OSprint(cast(string) s[0 .. 1]);
    }
    buf[i] = '\0';
    OSprint("\n");
}
// УТИЛИТЫ ДЛЯ РАБОТЫ СО СТРОКАМИ И ЧИСЛАМИ
bool strCmp(const char* s1, const char* s2)
{
    int i = 0;
    while (s1[i] != '\0' && s2[i] != '\0' && i < 15)
    {
        if (s1[i] != s2[i])
            return false;
        i++;
    }
    return (s1[i] == s2[i]);
}

bool isCmd(const char* bufPtr, string cmd)
{
    size_t i = 0;
    while (i < cmd.length)
    {
        if (bufPtr[i] != cmd[i])
            return false;
        i++;
    }
    return (bufPtr[i] == '\0' || bufPtr[i] == ' ');
}

void printInt(int n)
{
    if (n == 0)
    {
        OSprint("0");
        return;
    }
    if (n < 0)
    {
        OSprint("-");
        n = -n;
    }
    char[12] buf;
    int i = 10;
    buf[11] = '\0';
    while (n > 0 && i >= 0)
    {
        buf[i--] = cast(char)((n % 10) + '0');
        n /= 10;
    }
    OSprint(cast(string) buf[i + 1 .. 11]);
}

int stringToInt(const char* s)
{
    int res = 0;
    int sign = 1;
    int i = 0;
    if (s[0] == '-')
    {
        sign = -1;
        i++;
    }
    for (; s[i] >= '0' && s[i] <= '9'; ++i)
        res = res * 10 + (s[i] - '0');
    return res * sign;
}

int readInt()
{
    char[16] b;
    memset(b.ptr, 0, 16);
    OSinput(b.ptr, 16);
    return stringToInt(b.ptr);
}
// ATA PIO ДРАЙВЕР (ЖЕСТКИЙ ДИСК)
bool ata_wait()
{
    int timeout = 1000000;
    ubyte status;

    while (timeout > 0)
    {
        status = inb(0x1F7);

        // Если BSY (бит 7) чист и DRDY (бит 6) установлен — диск готов
        if (!(status & 0x80) && (status & 0x40))
        {
            return true;
        }

        // Если произошла ошибка (бит 0)
        if (status & 0x01)
            return false;

        // Если диск вообще не отвечает (0xFF), выходим сразу
        if (status == 0xFF)
            return false;

        timeout--;
    }
    return false;
}

bool read_sector(uint lba, ushort* buffer)
{
    // 1. Выбираем диск (Drive Select) и ждем готовности
    // 0xA0 - это Master Drive на Primary канале
    outb(0x1F6, cast(ubyte)(0xE0 | ((lba >> 24) & 0x0F)));

    // Небольшая пауза, чтобы контроллер переключился
    for (int i = 0; i < 4; i++)
        inb(0x3F6);

    if (!ata_wait())
        return false;

    // 2. Устанавливаем параметры чтения
    outb(0x1F2, 1); // Количество секторов (1)
    outb(0x1F3, cast(ubyte) lba); // LBA лоу-байт
    outb(0x1F4, cast(ubyte)(lba >> 8)); // LBA мид-байт
    outb(0x1F5, cast(ubyte)(lba >> 16)); // LBA хай-байт

    // 3. Посылаем команду READ SECTORS (0x20)
    outb(0x1F7, 0x20);

    // 4. Ждем, пока диск подготовит буфер данных (бит DRQ)
    int timeout = 1000000;
    while (timeout > 0)
    {
        ubyte s = inb(0x1F7);
        if (s & 0x08)
            break; // DRQ (бит 3) установлен — данные готовы
        if (s & 0x01)
            return false; // ERR установлен — что-то пошло не так
        timeout--;
    }

    if (timeout <= 0)
        return false;

    // 5. Читаем данные из порта (256 слов = 512 байт)
    for (int i = 0; i < 256; i++)
    {
        buffer[i] = inw(0x1F0);
    }

    return true;
}

void write_sector(uint lba, ubyte* buffer)
{
    if (!ata_wait())
        return;
    outb(0x1F6, cast(ubyte)(0xE0 | ((lba >> 24) & 0x0F)));
    outb(0x1F2, 1);
    outb(0x1F3, cast(ubyte) lba);
    outb(0x1F4, cast(ubyte)(lba >> 8));
    outb(0x1F5, cast(ubyte)(lba >> 16));
    outb(0x1F7, 0x30);
    if (!ata_wait())
        return;
    ushort* ptr = cast(ushort*) buffer;
    for (int i = 0; i < 256; i++)
        outw(0x1F0, ptr[i]);
}
// СТРУКТУРЫ ФАЙЛОВОЙ СИСТЕМЫ
enum MAX_FILES = 16;
enum MAX_FILE_SIZE = 256;

struct FileEntry
{
    char[16] name;
    char[MAX_FILE_SIZE] content;
    int parentIdx;
    bool isDir;
    bool exists;
}

__gshared FileEntry[MAX_FILES] fs;
__gshared int currentDir = 0;

bool sync_from_disk()
{
    return read_sector(100, cast(ushort*) fs.ptr);
}

void sync_to_disk()
{
    uint sectors = cast(uint)((MAX_FILES * FileEntry.sizeof) / 512) + 1;
    for (uint i = 0; i < sectors; i++)
    {
        write_sector(100 + i, (cast(ubyte*) fs.ptr) + (i * 512));
    }
}

int findInDir(char* name, int parent)
{
    for (int i = 0; i < MAX_FILES; i++)
    {
        if (fs[i].exists && fs[i].parentIdx == parent)
        {
            // Сравнение имен (учитываем, что name может быть char[16])
            bool match = true;
            for (int j = 0; j < 16; j++)
            {
                if (name[j] != fs[i].name[j])
                {
                    match = false;
                    break;
                }
                if (name[j] == '\0')
                    break;
            }
            if (match)
                return i;
        }
    }
    return -1;
}
// ВИЗУАЛЬНЫЕ ЭФФЕКТЫ И BSOD
void sleep(uint iterations)
{
    for (uint i = 0; i < iterations * 800000; i++)
        __asm("", "");
}

void printChar(char c, ubyte col = 0x0A)
{
    char[1] s;
    s[0] = c;
    OSprint(cast(string) s[0 .. 1], col);
}

void printPercent(int p)
{
    printChar(cast(char)((p / 10) + '0'));
    printChar(cast(char)((p % 10) + '0'));
    printChar('%');
}

void BSOD(string err)
{
    __asm("cli", "");
    for (int i = 0; i < 2000; i++)
        vram[i] = 0x1F20;
    curX = 0;
    curY = 0;
    OSprint("A problem has been detected and BelowOS has been shut down.\n", 0x1F);
    sleep(20);
    OSprint("KERNEL_MODE_EXCEPTION_NOT_HANDLED\n\n", 0x1F);
    sleep(15);
    OSprint("Technical Information:\n", 0x1F);
    sleep(15);
    OSprint("*** STOP: 0x0000008E (0xC0000005, 0xBF801111, 0xF9B4C, 0x00000000)\n", 0x1F);
    OSprint("*** ERROR: ", 0x1F);
    OSprint(err, 0x1F);
    sleep(30);
    OSprint("\n\nCPUID: 0x000006FD  EAX: 0x00000001  EBX: 0x00000000, ECX: 0x00FFFFFFF, EDX: 0x0AFF100B\n", 0x1F);
    sleep(30);
    OSprint("CR0: 0x80050033  CR2: 0x00000000  CR3: 0x00000000\n", 0x1F);
    sleep(30);
    OSprint("BSOD_ACTIVATED.\n\n", 0x1F);
    sleep(30);
    OSprint(
        "TRYINING TO RESTART IN 0x0000008E (0xC0000005, 0xBF801111, 0xF9B4C, 0x00000000), PLEASE SEE TEHNICAL INFO.\n", 0x1F);
    OSprint(err, 0x1F);
    OSprint("\n");
    sleep(40);
    OSprint("\nSystem halted. Please power off your machine manually.\n", 0x1F);
    sleep(15);
    OSprint("Rebooting...", 0x1F);
    sleep(1000);
    outb(0x64, 0xFE);
}

void OSmain()
{
    // 1. Начальная очистка экрана
    for (int i = 0; i < 2000; i++)
        vram[i] = 0;
    curX = 0;
    curY = 0;

    // 2. СЕКЦИЯ: FORCE WAKEUP (Пинаем контроллер ATA)
    for (int i = 0; i < 5; i++)
    {
        outb(0x1F6, 0xA0); // Выбираем Master Drive
        outb(0x1F7, 0x00); // NOP (пустая команда для прогрева)
        sleep(5);
    }
    sleep(50);

    // 3. ГИГАНТСКИЙ ASCII АРТ
    OSprint(" ##############################################################################\n", 0x0A);
    OSprint(" #  ____        _                 ____   _____                                #\n", 0x0A);
    OSprint(" # |  _ \\      | |               / __ \\ / ____|                               #\n", 0x0A);
    OSprint(" # | |_) | ___ | |  ___ __      | |  | | (___                                 #\n", 0x0A);
    OSprint(" # |  _ < / _ \\| | / _ \\\\ \\ /\\ / / |  | |\\___ \\                                #\n", 0x0A);
    OSprint(" # | |_) |  __/| || (_) |\\ V  V /| |__| |____) |                              #\n", 0x0A);
    OSprint(" # |____/ \\___||_| \\___/  \\_/\\_/  \\____/|_____/                                #\n", 0x0A);
    OSprint(" #                                                                            #\n", 0x0A);
    OSprint(" ############################  KERNEL v1.0.1 OK  ##############################\n\n", 0x0A);
    sleep(100);

    // 4. Диагностика железа
    OSprint("[ INFO ] CPU: Intel(R) i386 Processor Detected\n", 0x07);
    OSprint("[ INFO ] MEMORY: 2048KB Extended Memory Test... OK\n", 0x07);
    OSprint("[ INFO ] IDE: Initializing ATA Primary Controller...\n", 0x07);
    sleep(60);

    // 5. Прогресс бар загрузки
    OSprint("Loading Kernel Modules:\n", 0x0F);
    for (int i = 0; i <= 10; i++)
    {
        curX = 0;
        OSprint("  [", 0x0A);
        for (int j = 0; j < 20; j++)
        {
            if (j < i * 2)
                printChar('#');
            else
                printChar('.', 0x08);
        }
        OSprint("] ", 0x0A);
        printPercent(i * 10);
        sleep(20);
    }
    OSprint("\n");

    // 6. Сброс IDE контроллера
    OSprint("[ IDE ] Resetting Controller... ", 0x07);
    outb(0x1F6, 0xA0);
    sleep(10);
    outb(0x3F6, 0x04); // Software Reset (SRST)
    sleep(10);
    outb(0x3F6, 0x00);
    sleep(20);
    OSprint("DONE\n", 0x0A);

    // 7. Монтирование файловой системы
    OSprint("[ DISK ] Mounting Root FileSystem... ", 0x07);

    bool ok = sync_from_disk();
    ubyte final_stat = inb(0x1F7);

    if (!ok)
    {
        if (final_stat == 0xFF)
        {
            BSOD("DEVICE_NOT_FOUND_0xFF");
        }
        else if (final_stat == 0x00)
        {
            BSOD("CONTROLLER_ERROR_0x00");
        }
        else
        {
            // Диск найден, но не содержит валидной разметки
            OSprint("INITIALIZING... ", 0x0E);
            memset(fs.ptr, 0, fs.sizeof);
            fs[0].name[0 .. 4] = "root";
            fs[0].exists = true;
            fs[0].isDir = true;
            fs[0].parentIdx = -1;
            sync_to_disk();
            OSprint("OK\n", 0x0A);
        }
    }
    else
    {
        OSprint("SUCCESS\n", 0x02);
    }
    sleep(50);

    // 8. ВХОД В ТЕРМИНАЛ (Очистка под консоль)
    for (int i = 0; i < 2000; i++)
        vram[i] = 0x0720;
    curX = 0;
    curY = 0;
    OSprint("BelowOS Terminal [Version 1.0.1]\n", 0x0A);
    OSprint("Type 'help' for a list of commands.\n\n", 0x07);

    char[64] buf;
    while (1)
    {
        OSprint("root@user:", 0x02);
        OSprint(cast(string) fs[currentDir].name[0 .. 10], 0x0B);
        OSprint("# ", 0x0F);

        memset(buf.ptr, 0, 64);
        OSinput(buf.ptr, 64);
        if (buf[0] == '\0')
            continue;

        // --- ОБРАБОТКА КОМАНД ---
        if (isCmd(buf.ptr, "help"))
        {
            char* arg = cast(char*)(buf.ptr + 4);
            while (*arg == ' ' && *arg != '\0')
                arg++;

            if (*arg == '\0')
            {
                OSprint("Commands: ls, cd, mkdir, nfl, cat, edit, rm, cls, add, sub, mul, div, reboot, nuke, BSOD\n", 0x07);
                OSprint("Detailed help: help --[cmd] (e.g. help --ls)\n", 0x08);
            }
            else if (strCmp(arg, "--ls"))
            {
                OSprint("ls: Lists all files/dirs in the current directory.\n", 0x0E);
            }
            else if (strCmp(arg, "--cd"))
            {
                OSprint("cd [name]: Enter directory. 'cd ..' to go back to parent.\n", 0x0E);
            }
            else if (strCmp(arg, "--mkdir"))
            {
                OSprint("mkdir [name]: Creates a new directory on the disk.\n", 0x0E);
            }
            else if (strCmp(arg, "--nfl"))
            {
                OSprint("nfl [name]: Creates a new empty file entry.\n", 0x0E);
            }
            else if (strCmp(arg, "--cat"))
            {
                OSprint("cat [name]: Prints the text content of a file to the screen.\n", 0x0E);
            }
            else if (strCmp(arg, "--edit"))
            {
                OSprint("edit [name]: Simple buffer editor to modify file content.\n", 0x0E);
            }
            else if (strCmp(arg, "--rm"))
            {
                OSprint("rm [name]: Deletes a file or directory from the file system.\n", 0x0E);
            }
            else if (strCmp(arg, "--cls"))
            {
                OSprint("cls: Clears the VGA buffer and resets the cursor position.\n", 0x0E);
            }
            else if (strCmp(arg, "--add"))
            {
                OSprint("add: Arithmetic. Enter two numbers to get their sum.\n", 0x0E);
            }
            else if (strCmp(arg, "--sub"))
            {
                OSprint("sub: Arithmetic. Subtracts the second number from the first.\n", 0x0E);
            }
            else if (strCmp(arg, "--mul"))
            {
                OSprint("mul: Arithmetic. Multiplies two integers.\n", 0x0E);
            }
            else if (strCmp(arg, "--div"))
            {
                OSprint("div: Arithmetic. Integer division (checks for zero).\n", 0x0E);
            }
            else if (strCmp(arg, "--reboot"))
            {
                OSprint("reboot: Triggers a triple fault via PS/2 to restart the PC.\n", 0x0E);
            }
            else if (strCmp(arg, "--BSOD"))
            {
                OSprint("WARNING: TEST COMMAND. Manually triggers a kernel panic.\n", 0x0C);
            }
            else if (strCmp(arg, "--nuke"))
            {
                OSprint("DELETE FILE WITHOUT CHECK ROOT.\n", 0x0C);
            }
            else
            {
                OSprint("Unknown help flag. Usage: help --[command]\n", 0x0C);
            }
        }
        else if (isCmd(buf.ptr, "ls"))
        {
            bool found = false;
            for (int i = 0; i < MAX_FILES; i++)
            {
                if (fs[i].exists && fs[i].parentIdx == currentDir)
                {
                    OSprint(fs[i].isDir ? "[DIR] " : "[FIL] ", 0x0E);
                    OSprint(cast(string) fs[i].name[0 .. 15]);
                    OSprint("\n");
                    found = true;
                }
            }
            if (!found)
                OSprint("  (empty)\n", 0x08);
        }
        else if (isCmd(buf.ptr, "mkdir") || isCmd(buf.ptr, "nfl"))
        {
            bool isD = isCmd(buf.ptr, "mkdir");
            OSprint("Name: ");
            char[16] name;
            memset(name.ptr, 0, 16);
            OSinput(name.ptr, 16);
            int slot = -1;
            for (int i = 0; i < MAX_FILES; i++)
                if (!fs[i].exists)
                {
                    slot = i;
                    break;
                }
            if (slot != -1)
            {
                fs[slot].exists = true;
                fs[slot].isDir = isD;
                fs[slot].parentIdx = currentDir;
                for (int j = 0; j < 16; j++)
                    fs[slot].name[j] = name[j];
                memset(fs[slot].content.ptr, 0, MAX_FILE_SIZE);
                sync_to_disk();
                OSprint("Object created successfully.\n", 0x02);
            }
            else
                OSprint("Error: Disk full.\n", 0x0C);
        }
        else if (isCmd(buf.ptr, "edit"))
        {
            OSprint("File name: ");
            char[16] name;
            memset(name.ptr, 0, 16);
            OSinput(name.ptr, 16);
            int idx = findInDir(name.ptr, currentDir);
            if (idx != -1 && !fs[idx].isDir)
            {
                OSprint("Enter text: ");
                OSinput(fs[idx].content.ptr, MAX_FILE_SIZE);
                sync_to_disk();
                OSprint("File saved.\n", 0x02);
            }
            else
                OSprint("File not found.\n", 0x0C);
        }
        else if (isCmd(buf.ptr, "cat"))
        {
            OSprint("File name: ");
            char[16] name;
            memset(name.ptr, 0, 16);
            OSinput(name.ptr, 16);
            int idx = findInDir(name.ptr, currentDir);
            if (idx != -1 && !fs[idx].isDir)
            {
                OSprint("--- CONTENT ---\n", 0x07);
                OSprint(cast(string) fs[idx].content[0 .. MAX_FILE_SIZE]);
                OSprint("\n---------------\n", 0x07);
            }
            else
                OSprint("Error reading file.\n", 0x0C);
        }
        else if (isCmd(buf.ptr, "cd"))
        {
            OSprint("Target: ");
            char[16] name;
            memset(name.ptr, 0, 16);
            OSinput(name.ptr, 16);
            if (strCmp(name.ptr, ".."))
            {
                if (fs[currentDir].parentIdx != -1)
                    currentDir = fs[currentDir].parentIdx;
            }
            else
            {
                int idx = findInDir(name.ptr, currentDir);
                if (idx != -1 && fs[idx].isDir)
                    currentDir = idx;
                else
                    OSprint("Invalid directory.\n", 0x0C);
            }
        }
        else if (isCmd(buf.ptr, "rm"))
        {
            OSprint("Force Delete: ");
            char[16] name;
            memset(name.ptr, 0, 16);
            OSinput(name.ptr, 16);

            // 1. Сначала ищем по-нормальному
            int idx = findInDir(name.ptr, currentDir);

            // 2. Если не нашли, ищем ВООБЩЕ ВЕЗДЕ (Global Search)
            if (idx == -1)
            {
                for (int i = 1; i < MAX_FILES; i++)
                {
                    bool match = true;
                    for (int j = 0; j < 16; j++)
                    {
                        if (name[j] != fs[i].name[j])
                        {
                            match = false;
                            break;
                        }
                        if (name[j] == '\0')
                            break;
                    }
                    if (match && fs[i].exists)
                    {
                        idx = i;
                        break;
                    }
                }
            }

            if (idx == -1)
            {
                OSprint("Error: Object not found anywhere.\n", 0x0C);
            }
            else if (idx == 0)
            {
                OSprint("Access Denied: Root is eternal.\n", 0x0C);
            }
            else
            {
                // ПРИНУДИТЕЛЬНАЯ ОЧИСТКА
                fs[idx].exists = false;
                memset(fs[idx].name.ptr, 0, 16);
                memset(fs[idx].content.ptr, 0, MAX_FILE_SIZE); // Освобождаем ОЗУ
                fs[idx].parentIdx = -1;

                // Если мы удалили папку, в которой сидели — выкидываем в корень
                if (currentDir == idx)
                {
                    currentDir = 0;
                    OSprint("Warning: You deleted your current location. Back to root.\n", 0x0E);
                }

                sync_to_disk(); // Сохраняем на HDD
                OSprint("DELETED & MEMORY FREED.\n", 0x0A);
            }
        }
        else if (isCmd(buf.ptr, "nuke"))
        {
            OSprint("TARGET TO WIPE (NO PROTECT): ");
            char[16] name;
            memset(name.ptr, 0, 16);
            OSinput(name.ptr, 16);

            // Глобальный поиск индекса по всей таблице FS
            int idx = -1;
            for (int i = 0; i < MAX_FILES; i++)
            {
                if (fs[i].exists)
                {
                    bool match = true;
                    for (int j = 0; j < 16; j++)
                    {
                        if (name[j] != fs[i].name[j])
                        {
                            match = false;
                            break;
                        }
                        if (name[j] == '\0')
                            break;
                    }
                    if (match)
                    {
                        idx = i;
                        break;
                    }
                }
            }

            if (idx != -1)
            {
                OSprint("ERASING SLOT: ", 0x0E);
                printInt(idx);
                OSprint("\n");

                // ПОЛНАЯ АННИГИЛЯЦИЯ В ОЗУ
                fs[idx].exists = false;
                for (int j = 0; j < 16; j++)
                    fs[idx].name[j] = 0;
                for (int j = 0; j < MAX_FILE_SIZE; j++)
                    fs[idx].content[j] = 0;
                fs[idx].parentIdx = -1;
                fs[idx].isDir = false;

                // Если снес папку, в которой находишься - сбрасываем в корень
                if (currentDir == idx)
                {
                    currentDir = 0;
                }

                // запись на hdd
                sync_to_disk();

                OSprint("RAM FREED. DISK SECTOR WIPED. DONE.\n", 0x0A);
            }
            else
            {
                OSprint("Error: Target '", 0x0C);
                OSprint(cast(string) name[0 .. 10]);
                OSprint("' not found in memory.\n", 0x0C);
            }
        }
        else if (isCmd(buf.ptr, "cls"))
        {
            for (int i = 0; i < 2000; i++)
                vram[i] = 0x0720;
            curX = 0;
            curY = 0;
        }
        else if (isCmd(buf.ptr, "add") || isCmd(buf.ptr, "sub") || isCmd(buf.ptr, "mul") || isCmd(buf.ptr, "div"))
        {
            char op = buf[0];
            OSprint("A: ");
            size_t a = readInt();
            OSprint("B: ");
            size_t b = readInt();
            OSprint("Result: ");
            if (op == 'a')
                printInt(a + b);
            else if (op == 's')
                printInt(a - b);
            else if (op == 'm')
                printInt(a * b);
            else if (op == 'd')
            {
                if (b != 0)
                    printInt(a / b);
                else
                    OSprint("ERR:DIV0");
            }
            OSprint("\n");
        }
        else if (isCmd(buf.ptr, "BSOD"))
        {
            BSOD("ERROR_TRIGERED");
        }
        else if (isCmd(buf.ptr, "reboot"))
        {
            outb(0x64, 0xFE); // Команда контроллеру клавиатуры на Reset
        }
        else
        {
            OSprint("Unknown command. Type 'help'.\n", 0x07);
        }
    }
}
