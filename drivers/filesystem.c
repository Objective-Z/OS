#include "filesystem.h"

node_t* rootnode = 0;

u32 _read(node_t* fsnode, u32 offset, u32 size, u8* buffer){
	if (fsnode -> read != 0){
		return fsnode -> read(fsnode, offset, size, buffer);
	}
	else{
		return 0;
	}
}

u32 _write(node_t* fsnode, u32 offset, u32 size, u8* buffer){
	if (fsnode -> write != 0){
		return fsnode -> write(fsnode, offset, size, buffer);
	}
	else{
		return 0;
	}
}

void _open(node_t* fsnode, u8 read, u8 write){
	if (fsnode -> open != 0){
		fsnode -> read = _read(fsnode, 0, fsnode -> size, (u8*) read);
		fsnode -> write = _write(fsnode, 0, fsnode -> size, (u8*) write);
		fsnode -> open(fsnode);
	}
}

void _close(node_t* fsnode){
	if (fsnode -> close != 0){
		fsnode -> close(fsnode);
	}
}

struct dirent* _readdir(node_t* fsnode, u32 index){
	if ((fsnode -> flags & 0x7) == IS_DIRECTORY && fsnode -> readdir != 0){
		return fsnode -> readdir(fsnode, index);
	}
	else{
		return fsnode -> readdir;
	}
}

node_t* _finddir(node_t* fsnode, char* name){
	if ((fsnode -> flags & 0x7) == IS_DIRECTORY && fsnode -> finddir != 0){
		return fsnode -> finddir(fsnode, name);
	}
	else{
		return fsnode -> finddir;
	}
}
