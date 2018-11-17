#include "util.h"

void memory_copy(u8* source, u8* dest, int nbytes){
	int i;
	for (i = 0; i < nbytes; i++){
		*(dest + i) = *(source + i);
	}
}

void memory_set(u8* dest, u8 val, u32 len){
	u8* temp = (u8*) dest;
	for ( ; len != 0; len--){
		*temp++ = val;
	}
}

void int_to_ascii(int n, char str[]){
	int i;
	int sign;
	if ((sign = n) < 0){
		n = -n;
	}
	
	i = 0;
	do{
		str[i++] = (char) (n % 10) + '0';
	} while ((n /= 10) > 0);

	if (sign < 0){
		str[i++] = '-';
	}
	
	str[i] = '\0';
}

void reverse(char s[]){
	int c, i, j;
	for (i = 0, j = len(s) - 1; i < j; i++, j--){
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}

int len(char s[]){
	int i = 0;
	while (s[i] != '\0'){
		++i;
	}

	return i;
}

void input(char* text){
	if (strcmp(text, "END") == 0){
		kprint("Stopping the CPU...");
		asm volatile("hlt");
	}
	kprint("You said: ");
	kprint(text);
	kprint_newline();
	kprint("> ");
}

void append(char s[], char n){
	int length = len(s);
	s[length] = n;
	s[length + 1] = '\0';
}

void backspace(char s[]){
	int length = len(s);
	s[length - 1] = '\0';
}

int strcmp(char s1[], char s2[]){
	int i;
	for (i = 0; s1[i] == s2[i]; i++){
		if (s1[i] == '\0'){
			return 0;
		}
	}
	
	return s1[i] - s2[i];
}
