#include "keyboard.h"
#include "ports.h"
#include "screen.h"
#include "../cpu/isr.h"
#include "../kernel/util.h"

#define BACKSPACE 0x0e
#define ENTER 0x1c

#define MAX_CODE 57

static char buffer[256];

const char key_ascii[] = {'?', '?', '1', '2', '3', '4', '5', '6',     
    '7', '8', '9', '0', '-', '=', '?', '?', 'Q', 'W', 'E', 'R', 'T', 'Y', 
        'U', 'I', 'O', 'P', '[', ']', '?', '?', 'A', 'S', 'D', 'F', 'G', 
        'H', 'J', 'K', 'L', ';', '\'', '`', '?', '\\', 'Z', 'X', 'C', 'V', 
        'B', 'N', 'M', ',', '.', '/', '?', '?', '?', ' '};

static void keyboard_callback(registers_t regs){
	u8 key_code = port_byte_in(0x60);
	//char c;
	//int_to_ascii((int) key_code, c);
	//kprint(c);
	if (key_code > MAX_CODE){
		return;
	}
	else if (key_code == BACKSPACE){
		backspace(buffer);
		kprint_backspace();
	}
	else if (key_code == ENTER){
		kprint_newline();
		//kprint((u8*) '\n');
		input(buffer);
		buffer[0] = ' ';
	}
	else{
		//kprint(buffer);
		char letter = key_ascii[(int) key_code];
		char str[2] = {letter, '\0'};
		append(buffer, letter);
		kprint(str);
	}

	UNUSED(regs);
}

void init_keyboard(){
	register_interrupt_handler(IRQ1, keyboard_callback);
}
