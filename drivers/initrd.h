#ifndef INITRD_H
#define INITRD_H

#include "filesystem.h"

typedef struct{
	u32 nfiles;
} initrd_header_t;

typedef struct{
	u8 magic;
	s8 name[64];
	u32 offset;
	u32 size;
} initrd_file_header_t;

node_t* init_initrd(u32 loc);

#endif
