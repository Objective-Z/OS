#include "initrd.h"

initrd_header_t* initrd_header;
initrd_file_header_t* file_headers;
node_t* root;
node_t* dev;
node_t* root_nodes;
int nroot_nodes;

struct dirent dirent;

static u32 initrd_read(node_t* fsnode, u32 offset, u32 size, u8* buffer){
	initrd_file_header_t header = file_headers[fsnode -> inode];
	if (offset > header.size){
		return 0;
	}
	if (offset + size > header.size){
		size = header.size - offset;
	}

	memory_copy(buffer, (u8*)(header.offset + offset), size);
	return size;
}

/*static u32int initrd_write(node_t* fsnode, u32int offset, u32int size, u8int* buffer){
	initrd_file_header_t header = file_headers[fsnode -> inode];
	if (offset > header.size){
		return 0;
	}
	if (offset + size > header.size){
		size = header.size - offset;
	}

	memory_copy(buffer, (u8int*)(header.offset + offset), size);
	return size;
}*/

static struct dirent* initrd_readdir(node_t* fsnode, u32 index){
	if (fsnode == root && index == 0){
		strcpy(dirent.name, "dev");
		dirent.name[3] = 0;
		dirent.inode = 0;
		return &dirent;
	}
	if (index - 1 >= nroot_nodes){
		return 0;
	}

	strcpy(dirent.name, root_nodes[index - 1].name);
	dirent.name[len(root_nodes[index - 1].name)] = 0;
	dirent.inode = root_nodes[index - 1].inode;
	return &dirent;
}

static node_t* initrd_finddir(node_t* fsnode, char* name){
	if (fsnode == root && !strcmp(name, "dev")){
		return dev;
	}

	int i;
	for (i = 0; i < nroot_nodes; i++){
		if (!strcmp(name, root_nodes[i].name)){
			return &root_nodes[i];
		}
	}

	return 0;
}

node_t* init_initrd(u32 loc){
	initrd_header = (initrd_header_t*) loc;
	file_headers = (initrd_file_header_t*)(loc + sizeof(initrd_header_t));

	root = (node_t*) kmalloc(sizeof(node_t));
	strcpy(root -> name, "initrd");
	root -> perm_mask = root -> uid = root -> gid = root -> inode = root -> size = 0;
	root -> flags = IS_DIRECTORY;
	root -> read = 0;
	root -> write = 0;
	root -> open = 0;
	root -> close = 0;
	root -> readdir = &initrd_readdir;
	root -> finddir = &initrd_finddir;
	root -> ptr = 0;
	root -> impl = 0;

	dev = (node_t*) kmalloc(sizeof(node_t));
	strcpy(dev -> name, "dev");
	dev -> perm_mask = dev -> uid = dev -> gid = dev -> inode = dev -> size = 0;
	dev -> flags = IS_DIRECTORY;
	dev -> read = 0;
	dev -> write = 0;
	dev -> open = 0;
	dev -> close = 0;
	dev -> readdir = &initrd_readdir;
	dev -> finddir = &initrd_finddir;
	dev -> ptr = 0;
	dev -> impl = 0;

	root_nodes = (node_t*) kmalloc(sizeof(node_t) * initrd_header -> nfiles);
	nroot_nodes = initrd_header -> nfiles;

	int i;
	for (i = 0; i < initrd_header -> nfiles; i++){
		file_headers[i].offset += loc;
		strcpy(root_nodes[i].name, &file_headers[i].name);
		root_nodes[i].perm_mask = root_nodes[i].uid = root_nodes[i].gid = 0;
		root_nodes[i].size = file_headers[i].size;
		root_nodes[i].inode = i;
		root_nodes[i].flags = IS_FILE;
		root_nodes[i].read = &initrd_read;
		root_nodes[i].write = 0;
		root_nodes[i].readdir = 0;
		root_nodes[i].finddir = 0;
		root_nodes[i].open = 0;
		root_nodes[i].close = 0;
		root_nodes[i].impl = 0;
	}

	return root;
}
