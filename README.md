# BelowOSDev
Simple OS project for Dlang community
## BelowOS: Bare-Metal D Kernel

BelowOS is a minimalist 32-bit x86 operating system built from scratch using the **D programming language** in `-betterC` mode. This project demonstrates system-level programming without a standard library or runtime, focusing on direct hardware interaction and manual resource management.

---

### Technical Architecture

#### 1. Language and Runtime

The kernel is compiled using the `-betterC` subset of the D language. This ensures:

* **Zero Runtime Overhead**: No Garbage Collector (GC), TypeInfo, or ModuleInfo.
* **Static Linking**: The resulting binary is a freestanding ELF file capable of running directly on x86 hardware.
* **Manual Memory Control**: All memory operations are explicit, preventing hidden allocations.

#### 2. Storage Subsystem (ATA PIO)

Storage is handled by a custom Integrated Drive Electronics (IDE) driver operating in Programmed I/O (PIO) mode.

* **Direct Port I/O**: Communication occurs via I/O ports `0x1F0` through `0x1F7`.
* **Sector Synchronization**: The system implements a `sync_to_disk()` function that flushes the in-memory filesystem table directly to the disk sectors, ensuring persistence.

#### 3. Static Filesystem (Static-FS)

The filesystem uses a flat-indexed structure to represent hierarchical data:

* **Parent Indexing**: Every file entry stores a `parentIdx`, allowing for directory navigation without complex pointer trees.
* **Slot-Based Management**: The filesystem is an array of fixed-size structures.
* **The Nuke Mechanism**: To ensure RAM efficiency, a dedicated "Nuke" routine performs a byte-level zeroing of memory slots, physically clearing data from the system's address space.

#### 4. Video and UI

Output is managed via the VGA text buffer at memory address `0xB8000`.

* **16-Color Palette**: Uses a standard VGA attribute byte (4 bits for background, 4 bits for foreground).
* **Type Safety**: Core variables use `size_t` and `ptrdiff_t` to maintain architectural alignment and prevent overflow during memory addressing.

---

### Command Set

| Command | Operation | Priority |
| --- | --- | --- |
| `ls` | Scans the `fs` array for entries matching the `currentDir` index. | Standard |
| `cd` | Updates the `currentDir` pointer to the index of the target directory. | Standard |
| `nuke` | **Mandatory Erasure**. Zeroes out the name and content buffers in RAM and Disk. | Critical |
| `cls` | Fills the `0xB8000` buffer with empty characters and resets the cursor. | Utility |
| `BSOD` | Triggers a manual write of all cached filesystem entries to the HDD image. | System |
*and more)*

---

### Development and Deployment

#### Build Requirements

* **LDC2**: LLVM-based D Compiler.
* **NASM**: For the 16-bit real-mode bootloader.
* **GNU Make**: Project automation.
* **QEMU**: Hardware emulation (i386).

#### Execution

1. Compile the bootloader and kernel using the provided Linker Script.
2. Generate a raw `hdd.img` file for storage emulation.
3. Launch via QEMU:
```bash
qemu-system-i386 -drive file=hdd.img,format=raw

```



---

### Implementation Details

* **Freestanding Environment**: No dependency on `libc` or `libphobos`.
* **Memory Mapping**: Uses custom aliases for system-specific types to ensure portability across different x86 compilers.
* **Hardware Reset**: Implements a soft-reboot via the PS/2 controller (Port `0x64`).
