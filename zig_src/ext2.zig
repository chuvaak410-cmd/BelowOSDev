const std = @import("std");

extern fn read_sector(lba: u32, buffer: [*]u16) bool;
extern fn write_sector(lba: u32, buffer: [*]u8) void;
extern fn ext2_dir_callback(name: [*]const u8, name_len: u32, inode: u32, is_dir: bool) void;

pub const EXT2_SUPER_MAGIC = 0xEF53;
pub const EXT2_ROOT_INO = 2;

pub const Superblock = extern struct {
    s_inodes_count: u32,
    s_blocks_count: u32,
    s_r_blocks_count: u32,
    s_free_blocks_count: u32,
    s_free_inodes_count: u32,
    s_first_data_block: u32,
    s_log_block_size: u32,
    s_log_frag_size: i32,
    s_blocks_per_group: u32,
    s_frags_per_group: u32,
    s_inodes_per_group: u32,
    s_mtime: u32,
    s_wtime: u32,
    s_mnt_count: u16,
    s_max_mnt_count: i16,
    s_magic: u16,
    s_state: u16,
    s_errors: u16,
    s_minor_rev_level: u16,
    s_lastcheck: u32,
    s_checkinterval: u32,
    s_creator_os: u32,
    s_rev_level: u32,
    s_def_resuid: u16,
    s_def_resgid: u16,
    s_first_ino: u32,
    s_inode_size: u16,
    s_block_group_nr: u16,
    s_feature_compat: u32,
    s_feature_incompat: u32,
    s_feature_ro_compat: u32,
    s_uuid: [16]u8,
    s_volume_name: [16]u8,
    s_last_mounted: [64]u8,
    s_algo_bitmap: u32,
    s_prealloc_blocks: u8,
    s_prealloc_dir_blocks: u8,
    alignment: u16,
    s_journal_uuid: [16]u8,
    s_journal_inum: u32,
    s_journal_dev: u32,
    s_last_orphan: u32,
    s_hash_seed: [4]u32,
    s_def_hash_version: u8,
    padding_1: [3]u8,
    s_default_mount_opts: u32,
    s_first_meta_bg: u32,
    padding_2: [760]u8,
};

pub const BlockGroupDescriptor = extern struct {
    bg_block_bitmap: u32,
    bg_inode_bitmap: u32,
    bg_inode_table: u32,
    bg_free_blocks_count: u16,
    bg_free_inodes_count: u16,
    bg_used_dirs_count: u16,
    bg_pad: u16,
    bg_reserved: [12]u8,
};

pub const Inode = extern struct {
    i_mode: u16,
    i_uid: u16,
    i_size: u32,
    i_atime: u32,
    i_ctime: u32,
    i_mtime: u32,
    i_dtime: u32,
    i_gid: u16,
    i_links_count: u16,
    i_blocks: u32,
    i_flags: u32,
    i_osd1: u32,
    i_block: [15]u32,
    i_generation: u32,
    i_file_acl: u32,
    i_dir_acl: u32,
    i_faddr: u32,
    i_osd2: [12]u8,
};

pub const DirEntry = extern struct {
    inode: u32,
    rec_len: u16,
    name_len: u8,
    file_type: u8,
};

var global_sb: Superblock = undefined;
var base_lba: u32 = 0;
var block_size: u32 = 0;
var group_count: u32 = 0;
var inode_size: u32 = 0;

var g_indirect_1: [8192]u8 align(4) = undefined;
var g_indirect_2: [8192]u8 align(4) = undefined;
var g_dir_buf: [8192]u8 align(4) = undefined;
var g_read_buf: [8192]u8 align(4) = undefined;

fn read_block(disk_blk: u32, dest: [*]u8) bool {
    const sectors_per_block = block_size / 512;
    var sec: u32 = 0;
    while (sec < sectors_per_block) : (sec += 1) {
        const ptr = @as([*]u16, @ptrCast(@alignCast(dest + sec * 512)));
        if (!read_sector(base_lba + (disk_blk * sectors_per_block) + sec, ptr)) {
            return false;
        }
    }
    return true;
}

export fn ext2_init(lba: u32) bool {
    base_lba = lba;
    
    var sb_buf: [1024]u8 align(4) = undefined;
    const buf_u16 = @as([*]u16, @ptrCast(&sb_buf));
    if (!read_sector(base_lba + 2, buf_u16)) return false;
    if (!read_sector(base_lba + 3, buf_u16 + 256)) return false;

    global_sb = @as(*Superblock, @ptrCast(&sb_buf)).*;

    if (global_sb.s_magic != EXT2_SUPER_MAGIC) return false;

    block_size = @as(u32, 1024) << @as(u5, @intCast(global_sb.s_log_block_size));
    if (block_size > 8192) return false;
    
    if (global_sb.s_rev_level == 0) {
        inode_size = 128;
    } else {
        inode_size = global_sb.s_inode_size;
    }

    const blocks_per_group = if (global_sb.s_blocks_per_group > 0) global_sb.s_blocks_per_group else 8192;
    group_count = (global_sb.s_blocks_count + blocks_per_group - 1) / blocks_per_group;

    return true;
}

fn get_bgd(group: u32, bgd: *BlockGroupDescriptor) bool {
    const bgdt_block = if (block_size == 1024) @as(u32, 2) else @as(u32, 1);
    const bgdt_offset = bgdt_block * block_size;
    const bgd_byte_offset = bgdt_offset + (group * @sizeOf(BlockGroupDescriptor));
    
    const sector_offset = bgd_byte_offset / 512;
    const offset_in_sector = bgd_byte_offset % 512;
    
    var sector_buf: [512]u8 align(4) = undefined;
    if (!read_sector(base_lba + sector_offset, @as([*]u16, @ptrCast(&sector_buf)))) return false;
    
    bgd.* = @as(*BlockGroupDescriptor, @ptrCast(@alignCast(&sector_buf[offset_in_sector]))).*;
    return true;
}

fn read_inode(inode_num: u32, inode: *Inode) bool {
    if (inode_num == 0) return false;
    const index = inode_num - 1;
    const group = index / global_sb.s_inodes_per_group;
    const local_index = index % global_sb.s_inodes_per_group;

    var bgd: BlockGroupDescriptor = undefined;
    if (!get_bgd(group, &bgd)) return false;

    const inode_table_block = bgd.bg_inode_table;
    const byte_offset = local_index * inode_size;
    const sector_offset = (inode_table_block * (block_size / 512)) + (byte_offset / 512);
    const offset_in_sector = byte_offset % 512;

    var sector_buf: [512]u8 align(4) = undefined;
    if (!read_sector(base_lba + sector_offset, @as([*]u16, @ptrCast(&sector_buf)))) return false;
    
    if (offset_in_sector + @sizeOf(Inode) <= 512) {
        inode.* = @as(*Inode, @ptrCast(@alignCast(&sector_buf[offset_in_sector]))).*;
    } else {
        var dbl_buf: [1024]u8 align(4) = undefined;
        @memcpy(dbl_buf[0..512], sector_buf[0..512]);
        if (!read_sector(base_lba + sector_offset + 1, @as([*]u16, @ptrCast(&dbl_buf[512])))) return false;
        inode.* = @as(*Inode, @ptrCast(@alignCast(&dbl_buf[offset_in_sector]))).*;
    }
    return true;
}

fn get_file_block(inode: *const Inode, block_index: u32) u32 {
    if (block_index < 12) {
        return inode.i_block[block_index];
    }
    
    const ptrs_per_block = block_size / 4;
    var current_index = block_index - 12;

    if (current_index < ptrs_per_block) {
        if (inode.i_block[12] == 0) return 0;
        if (!read_block(inode.i_block[12], &g_indirect_1)) return 0;
        const ptrs = @as([*]u32, @ptrCast(&g_indirect_1));
        return ptrs[current_index];
    }
    
    current_index -= ptrs_per_block;
    const ptrs_per_block_sq = ptrs_per_block * ptrs_per_block;
    
    if (current_index < ptrs_per_block_sq) {
        if (inode.i_block[13] == 0) return 0;
        if (!read_block(inode.i_block[13], &g_indirect_1)) return 0;
        
        const lvl1_index = current_index / ptrs_per_block;
        const lvl2_index = current_index % ptrs_per_block;
        
        const lvl1_ptrs = @as([*]u32, @ptrCast(&g_indirect_1));
        const block_lvl2 = lvl1_ptrs[lvl1_index];
        if (block_lvl2 == 0) return 0;
        
        if (!read_block(block_lvl2, &g_indirect_2)) return 0;
        const lvl2_ptrs = @as([*]u32, @ptrCast(&g_indirect_2));
        return lvl2_ptrs[lvl2_index];
    }
    return 0;
}

export fn ext2_read_file(inode_num: u32, dest_buf: [*]u8, max_len: u32) u32 {
    var inode: Inode = undefined;
    if (!read_inode(inode_num, &inode)) return 0;

    const file_size = if (inode.i_size < max_len) inode.i_size else max_len;
    var bytes_read: u32 = 0;
    var block_idx: u32 = 0;

    while (bytes_read < file_size) {
        const disk_blk = get_file_block(&inode, block_idx);
        if (disk_blk != 0) {
            if (!read_block(disk_blk, &g_read_buf)) return bytes_read;
        } else {
            @memset(g_read_buf[0..block_size], 0);
        }

        const remaining = file_size - bytes_read;
        const to_copy = if (remaining < block_size) remaining else block_size;
        
        @memcpy(dest_buf[bytes_read .. bytes_read + to_copy], g_read_buf[0..to_copy]);
        bytes_read += to_copy;
        block_idx += 1;
    }
    return bytes_read;
}

export fn ext2_get_file_size(inode_num: u32) u32 {
    var inode: Inode = undefined;
    if (!read_inode(inode_num, &inode)) return 0;
    return inode.i_size;
}

export fn ext2_is_dir(inode_num: u32) bool {
    var inode: Inode = undefined;
    if (!read_inode(inode_num, &inode)) return false;
    return (inode.i_mode & 0xF000) == 0x4000;
}

export fn ext2_find_file(parent_inode: u32, name: [*]const u8, name_len: u32) u32 {
    var inode: Inode = undefined;
    if (!read_inode(parent_inode, &inode)) return 0;
    if ((inode.i_mode & 0xF000) != 0x4000) return 0; 

    var block_idx: u32 = 0;
    var bytes_read: u32 = 0;
    
    while (bytes_read < inode.i_size) {
        const disk_blk = get_file_block(&inode, block_idx);
        if (disk_blk == 0) break;
        if (!read_block(disk_blk, &g_dir_buf)) return 0;

        var offset: u32 = 0;
        while (offset < block_size and bytes_read + offset < inode.i_size) {
            const de = @as(*DirEntry, @ptrCast(@alignCast(&g_dir_buf[offset])));
            if (de.inode == 0 and de.rec_len == 0) break;
            if (de.rec_len == 0) break;

            if (de.inode != 0 and de.name_len == name_len) {
                const de_name = g_dir_buf[offset + @sizeOf(DirEntry) .. offset + @sizeOf(DirEntry) + name_len];
                var match = true;
                var i: u32 = 0;
                while (i < name_len) : (i += 1) {
                    if (de_name[i] != name[i]) {
                        match = false;
                        break;
                    }
                }
                if (match) return de.inode;
            }
            offset += de.rec_len;
        }
        bytes_read += block_size;
        block_idx += 1;
    }
    return 0;
}

export fn ext2_list_dir(parent_inode: u32) void {
    var inode: Inode = undefined;
    if (!read_inode(parent_inode, &inode)) return;
    if ((inode.i_mode & 0xF000) != 0x4000) return; 

    var block_idx: u32 = 0;
    var bytes_read: u32 = 0;
    
    while (bytes_read < inode.i_size) {
        const disk_blk = get_file_block(&inode, block_idx);
        if (disk_blk == 0) break;
        if (!read_block(disk_blk, &g_dir_buf)) return;

        var offset: u32 = 0;
        while (offset < block_size and bytes_read + offset < inode.i_size) {
            const de = @as(*DirEntry, @ptrCast(@alignCast(&g_dir_buf[offset])));
            if (de.inode == 0 and de.rec_len == 0) break;
            if (de.rec_len == 0) break;

            if (de.inode != 0) {
                const is_dir = de.file_type == 2;
                const de_name = @as([*]const u8, @ptrCast(&g_dir_buf[offset + @sizeOf(DirEntry)]));
                ext2_dir_callback(de_name, de.name_len, de.inode, is_dir);
            }
            offset += de.rec_len;
        }
        bytes_read += block_size;
        block_idx += 1;
    }
}
