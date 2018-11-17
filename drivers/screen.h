#ifndef SCREEN_H
#define SCREEN_H

#include "../cpu/types.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 50
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#define RED_ON_BLACK 0x04

//screen I/O ports
#define SCREEN_CTRL 0x3d4
#define SCREEN_DATA 0x3d5

//public kernel API
void clear_screen();
void kprint_at(u8* message, int col, int row);
void kprint(u8* message);
void kprint_backspace();
void kprint_newline();

#endif
