module sys.boot.kernel.odin_debug;

extern(C) {
    // Функции логирования, реализованные на Odin
    void odin_debug_log(const char* msg);
    void odin_debug_int(const char* msg, int val);
    void odin_debug_hex(const char* msg, uint val);
    void odin_debug_assert(bool condition, const char* msg);
}
