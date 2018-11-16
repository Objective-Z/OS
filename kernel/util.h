#ifndef UTIL_H
#define UTIL_H

#include "../cpu/types.h"

void memory_copy(char* source, char* dest, int nbytes);
void memory_set(u8* dest, u8 val, u32 len);
void int_to_ascii(int n, char str[]);
void reverse(char s[]);
int len(char s[]);
void input(char* text);
void append(char s[], char n);
void backspace(char s[]);
int strcmp(char s1[], char s2[]);

#define UNUSED(x) (void)(x)

#endif
