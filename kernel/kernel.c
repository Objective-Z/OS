#include "../drivers/screen.h"
#include "../drivers/ports.h"
#include "util.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"
//#include <string.c>

void kmain(){
	clear_screen();
	isr_install();
	irq_install();
	kprint("Type something.  It will go through the kernel.");
	kprint_newline();
	kprint("> ");
}
