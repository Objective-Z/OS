#include "../drivers/filesystem.h"
#include "../drivers/screen.h"
#include "../drivers/ports.h"
#include "util.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"
//#include <string.c>

void kmain(){
	isr_install();
	irq_install();
	clear_screen();

	u32 initrd_loc = *((u32*) 0x0000);
	u32 initrd_end = *((u32*) 0x7b00);
	rootnode = init_initrd(initrd_loc);
	/*int offset = get_offset(1, 1);
	set_cursor_offset(offset);
	kprint("Type something.  It will go through the kernel.");
	kprint_newline();
	//kprint_newline();
	kprint("> ");*/
	//asm volatile("call 0x0000");
	int i = 0;

	struct dirent* dirnode = 0;
	while ((dirnode = _readdir(rootnode, i)) != 0){
		//int j;
		//char ch[1];
		//for (j = 0; (dirnode -> name)[j] != '\0'; j++){
		//	int_to_ascii((dirnode -> name)[j], ch);
		//	kprint(ch);
		//}
		kprint(dirnode -> name);
		node_t* fsnode = _finddir(rootnode, dirnode -> name);
		if ((fsnode -> flags & 0x7) == IS_DIRECTORY){
			kprint_newline();
			kprint("(directory)");
			kprint_newline();
		}
		else{
			//kprint(fsnode -> name);
			//kprint(dirnode -> name);
			kprint_newline();
			kprint("contents: ");
			char buf[256];
			u32 sz = _read(fsnode, 0, 256, buf);
			int j;
			for (j = 0; j < sz; j++){
				kprint(buf[j]);
			}

			kprint_newline();
		}

		i++;
	}
}
