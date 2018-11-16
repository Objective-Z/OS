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

/*const char key_ascii[] = {
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
	};*/

const char key_ascii[] = {'?', '?', '1', '2', '3', '4', '5', '6',
			'7', '8', '9', '0', '-', '=', '?', '?',
			'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I',
			'O', 'P', '[', ']', '?', '?', 'A', 'S', 
			'D', 'F', 'G', 'H', 'J', 'K', 'L', ';',
			'\'', '`', '?', '\\', 'Z', 'X', 'C', 'V',
			'B', 'N', 'M', ',', '.', '/', '?', '?', '?',
			' '};

static void keyboard_callback(registers_t regs){
	u8 scan_code = port_byte_in(0x60);
	if (scan_code > 57){
		return;
	}
	if (scan_code == BACKSPACE){
		backspace(buffer);
		kprint_backspace();
	}
	else if (scan_code == ENTER){
		kprint_newline();
		input(buffer);
		buffer[0] = '\0';
	}
	else{
		char* letter = (char*) key_ascii[(int) scan_code];
		char str[] = {letter, '\0'};
		append(buffer, letter);
		kprint(str);
	}

	UNUSED(regs);
}

void init_keyboard(){
	register_interrupt_handler(IRQ1, keyboard_callback);
}
