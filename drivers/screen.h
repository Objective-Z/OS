#ifndef SCREEN_H
#define SCREEN_H

#include "../cpu/types.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#define RED_ON_BLACK 0xf4

//screen I/O ports
#define SCREEN_CTRL 0x3d4
#define SCREEN_DATA 0x3d5

//public kernel API
void clear_screen();
void kprint_at(char* message, int col, int row);
void kprint(char* message);
void kprint_newline();
void kprint_backspace();

#endif
