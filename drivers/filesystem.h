#ifndef FILESYSTEM_H
#define FILESYSTEM_H

#include "../cpu/types.h"

#define IS_FILE 0x01
#define IS_DIRECTORY 0x02
#define IS_CHARDEVICE 0x03
#define IS_BLOCKDEVICE 0x04
#define IS_PIPE 0x05
#define IS_SYMLINK 0x06
#define IS_MOUNTPOINT 0x08

typedef u32 (*read_t)(struct node*, u32, u32, u8*);
typedef u32 (*write_t)(struct node*, u32, u32, u8*);
typedef void (*open_t)(struct node*);
typedef void (*close_t)(struct node*);
typedef struct dirent* (*readdir_t)(struct node*, u32);
typedef struct node* (*finddir_t)(struct node*, char* name);

typedef struct node{
	char name[128];
	u32 perm_mask;
	u32 uid;
	u32 gid;
	u32 flags;
	u32 inode;
	u32 size;
	u32 impl;
	read_t read;
	write_t write;
	open_t open;
	close_t close;
	readdir_t readdir;
	finddir_t finddir;
	struct node *ptr;
} node_t;

struct dirent{
	char name[128];
	u32 inode;
};

extern node_t* rootnode;

u32 _read(node_t* fsnode, u32 offset, u32 size, u8* buffer);
u32 _write(node_t* fsnode, u32 offset, u32 size, u8* buffer);
void _open(node_t* fsnode, u8 read, u8 write);
void _close(node_t* fsnode);
struct dirent* _readdir(node_t* fsnode, u32 index);
node_t* _finddir(node_t* fsnode, char* name);

#endif
