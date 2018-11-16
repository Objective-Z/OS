#include "idt.h"
#include "../kernel/util.h"

void set_idt_gate(int n, u32 the_handler){
	idt[n].low_offset = low_16(the_handler);
	idt[n].kernel_selector = KERNEL_CS;
	idt[n].always0 = 0;
	idt[n].flags = 0x8e;
	idt[n].high_offset = high_16(the_handler);
}

void set_idt(){
	idt_register.base = (u32) &idt;
	idt_register.limit = (u16) (IDT_ENTRIES * sizeof(idt_gate_t) - 1);

	__asm__ __volatile__("lidtl (%0)" : : "r" (&idt_register));
}
