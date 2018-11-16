#ifndef IDT_H
#define IDT_H

#include "types.h"

//segment selectors
#define KERNEL_CS 0x08

//definition of an interrupt gate
typedef struct{
	u16 low_offset;
	u16 kernel_selector;
	u8 always0;
	//first byte
	//bit 7: "interrupt is present"
	//bits 6 - 5: privilage level of caller (0 = kernel ... 3 = user)
	//bit 4: set to 0 for interrupt gates
	//bits 3 - 0: bits 1110 (decimal 14) means 32-bit interrupt gate
	u8 flags;
	u16 high_offset;
} __attribute__((packed)) idt_gate_t;

//pointer to array of interrupt handlers.  assembly instruction lidt 
//will read it
typedef struct{
	u16 limit;
	u32 base;
} __attribute__((packed)) idt_register_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_register;

void set_idt_gate(int n, u32 the_handler);
void set_idt();

#endif
