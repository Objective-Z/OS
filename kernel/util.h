#ifndef UTIL_H
#define UTIL_H

#include "../cpu/types.h"

void memory_copy(u8* source, u8* dest, int nbytes);
void memory_set(u8* dest, u8 val, u32 len);
void int_to_ascii(int n, char str[]);
void reverse(char s[]);
int len(char s[]);
void input(char* text);
void append(char s[], char n);
void backspace(char s[]);
int strcmp(char s1[], char s2[]);
char* strcpy(char* dest, const char* src);
u32 kmalloc(u32 size);

#define UNUSED(x) (void)(x)

#endif
