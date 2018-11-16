#include "screen.h"
#include "ports.h"
#include "../kernel/util.h"

int get_cursor_offset();
void set_cursor_offset(int offset);
int print_char(char c, int col, int row, char attr);
int get_offset(int col, int row);
int get_offset_row(int offset);
int get_offset_col(int offset);

//public kernel API

//print message at the specified location.  if row or col is negative, use current offset
void kprint_at(char* message, int col, int row){
	//set cursor position if col or row is negative
	int offset;
	if (col >= 0 && row >= 0){
		offset = get_offset(col, row);
	}
	else{
		offset = get_cursor_offset();
		row = get_offset_row(offset);
		col = get_offset_col(offset);
	}

	//print message by looping through each character
	/***************************************************
	*			UNTESTED		   *	
	***************************************************/
	int i = 0;
	while(message[i] != 0){ 
		offset = print_char(message[i++], col, row, WHITE_ON_BLACK);
		//determine the next row and col
		row = get_offset_row(offset);
		col = get_offset_col(offset);
	}
}

//print message at current offset
void kprint(char* message){
	kprint_at(message, -1, -1);
}

void kprint_backspace(){
	int offset = get_cursor_offset() - 2;
	int row = get_offset_row(offset);
	int col = get_offset_col(offset);
	print_char(0x08, col, row, WHITE_ON_BLACK);
}

void kprint_newline(){
	int offset = get_cursor_offset();
	int row = get_offset_row(offset);
	kprint_at((char*) " ", 0, row + 1);
}

//private kernel functions

//access video memory to print a character to the screen. 
// if col and row are negative, print at current offset. 
// if attr is 0, print white character on black background.  
//return the offset of the next character.  set the cursor 
//to the next offset.
int print_char(char c, int col, int row, char attr){
	unsigned char* vidmem = (unsigned char*) VIDEO_ADDRESS;
	if (!attr){
		attr = WHITE_ON_BLACK;
	}

	//print red E if the coordinates are invalid
	if (col >= MAX_COLS || row >= MAX_ROWS){
		vidmem[2 * MAX_COLS * MAX_ROWS - 2] = 'E';
		vidmem[2 * MAX_COLS * MAX_ROWS - 1] = RED_ON_BLACK;
		return get_offset(col, row);
	}

	int offset;
	if (col >= 0 && row >= 0){
		offset = get_offset(col, row);
	}
	else{
		offset = get_cursor_offset();
	}

	if (c == '\n'){
		row = get_offset_row(offset);
		offset = get_offset(0, row + 1);
	}
	else{
		vidmem[offset] = c;
		vidmem[offset + 1] = attr;
		offset += 2;
	}

	//is offset larger than screen size?  if so, scroll.
	if (offset >= 2 * MAX_COLS * MAX_ROWS){
		int i;
		for (i = 1; i < MAX_ROWS; i++){
			memory_copy(get_offset(0, i) + VIDEO_ADDRESS, get_offset(0, i - 1) + VIDEO_ADDRESS, 2 * MAX_COLS);
		}
		
		//blank line
		char* last_line = get_offset(0, MAX_ROWS - 1) + VIDEO_ADDRESS;
		for (i = 0; i < 2 * MAX_COLS; i++){
			last_line[i] = 0;
		}
		offset -= 2 * MAX_COLS;
	}

	set_cursor_offset(offset);
	return offset;
}

//use VGA port to get current cursor position.
int get_cursor_offset(){
	//ask for high byte of the offset (data 14).  
	//then ask for low byte of the offset (data 15).
	port_byte_out(SCREEN_CTRL, 14);
	int offset = port_byte_in(SCREEN_DATA) << 8;
	port_byte_out(SCREEN_CTRL, 15);
	offset += port_byte_in(SCREEN_DATA);
	//return (size of character cell * cursor position)
	return 2 * offset;
}

//write data instead of reading data
void set_cursor_offset(int offset){
	offset /= 2;
	port_byte_out(SCREEN_CTRL, 14);
	port_byte_out(SCREEN_DATA, (u8) offset >> 8);
	port_byte_out(SCREEN_CTRL, 15);
	port_byte_out(SCREEN_DATA, (u8)(offset & 0xff));
}

void clear_screen(){
	int screen_size = MAX_COLS * MAX_ROWS;
	int i;
	char* screen = (char*) VIDEO_ADDRESS;

	for (i = 0; i < screen_size; i++){
		screen[i * 2] = ' ';
		screen[i * 2 + 1] = WHITE_ON_BLACK;
	}
	set_cursor_offset(get_offset(0, 0));
}

int get_offset(int col, int row){
	return 2 * (row * MAX_COLS + col);
}

int get_offset_row(int offset){
	return offset / (2 * MAX_COLS);
}

int get_offset_col(int offset){
	return (offset - (get_offset_row(offset) * 2 * MAX_COLS)) / 2;
}
