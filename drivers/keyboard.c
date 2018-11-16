#include "keyboard.h"
#include "ports.h"
#include "screen.h"
#include "../cpu/isr.h"
#include "../kernel/util.h"

#define BACKSPACE 0x0e
#define ENTER 0x1c

static char buffer[256];

const char* key_names[] = {
                'A',
                'B',
                'C',
                'D',
                'E',
                'F',
                'G',
                'H',
                'I',
                'J',
                'K',
                'L',
                'M',
                'N',
                'O',
                'P',
                'Q',
                'R',
                'S',
                'T',
		'U',
                'V',
                'W',
                'X',
                'Y',
                'Z'
	};

const char key_ascii[] = {
		'A',
		'B',
		'C',
		'D',
		'E',
		'F',
		'G',
		'H',
		'I',
		'J',
		'K',
		'L',
		'M',
		'N',
		'O',
		'P',
		'Q',
		'R',
		'S',
		'T',
		'U',
		'V',
		'W',
		'X',
		'Y',
		'Z'
	};

static void keyboard_callback(registers_t regs){
	u8 key_code = port_byte_in(0x60);
	if (key_code == BACKSPACE){
		backspace(buffer);
		kprint_backspace();
	}
	else if (key_code == ENTER){
		kprint("\n");
		input(buffer);
		buffer[0] = '\0';
	}
	else{
		kprint(buffer);
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
