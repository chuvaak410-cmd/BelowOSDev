module sys.boot.kernel.ext2;
import kernel; // Для доступа к OSprint и другим функциям ядра

extern (C)
{
    // Внутренние функции Zig, которые можно вызывать из D
    bool ext2_init(uint lba);
    uint ext2_read_file(uint inode, ubyte* dest_buf, uint max_len);
    uint ext2_get_file_size(uint inode);
    bool ext2_is_dir(uint inode);
    uint ext2_find_file(uint parent_inode, const char* name, uint name_len);
    void ext2_list_dir(uint parent_inode);
}

// Колбэк, который Zig вызывает для каждого найденного файла/папки при ext2_list_dir
extern (C) void ext2_dir_callback(const char* name, uint name_len, uint inode, bool is_dir)
{
    // Пропускаем ссылки на текущую и родительскую директорию (. и ..) если нужно
    if (name[0] == '.' && (name_len == 1 || (name_len == 2 && name[1] == '.')))
    {
        return;
    }

    OSprint(is_dir ? "[DIR] " : "[FIL] ", 0x0E);

    // В Zig строки не закачиваются нулем, поэтому берем срез нужной длины
    OSprint(cast(string) name[0 .. name_len]);
    OSprint("\n");
}

// Пример использования (вы можете интегрировать этот код в свой шелл в header.d):
/*
void test_ext2() {
    // Инициализируем EXT2 на разделе (например, LBA 2048)
    if (ext2_init(2048)) {
        OSprint("EXT2 successfully initialized!\n", 0x02);
        
        uint root_inode = 2; // EXT2_ROOT_INO
        OSprint("--- Root Directory ---\n");
        ext2_list_dir(root_inode);
        
        // Пример поиска файла и его чтения:
        string fname = "test.txt";
        uint file_ino = ext2_find_file(root_inode, fname.ptr, cast(uint)fname.length);
        if (file_ino != 0) {
            uint size = ext2_get_file_size(file_ino);
            char[512] buf;
            uint read_bytes = ext2_read_file(file_ino, cast(ubyte*)buf.ptr, 512);
            // вывести содержимое...
        }
    } else {
        OSprint("Failed to init EXT2\n", 0x0C);
    }
}
*/
