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
	int offset = get_offset(1, 1);
	set_cursor_offset(offset);
	kprint("Type something.  It will go through the kernel.");
	kprint_newline();
	//kprint_newline();
	kprint("> ");
}
