#include "ports.h"

//Read byte from specified port
u8 port_byte_in(u16 port){
	u8 result;
	//input byte from I/O port address dx into al.  set result equal to eax and map port into edx register.
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}

void port_byte_out(u16 port, u8 data){
	//output al to I/O port address dx and map data and port to eax and edx respectively.
	__asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

u16 port_word_in(u16 port){
	u16 result;
	//input I/O port address dx into ax and map result 
	//to eax and port to edx
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;
}

void port_word_out(u16 port, u16 data){
	__asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}
