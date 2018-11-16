[bits 32]

;define constants
VIDEO_MEMORY equ 0xb8000 ;location of video memory
WHITE_ON_BLACK equ 0x0f ;color byte for each character

print_string32:
	pusha
	mov edx, VIDEO_MEMORY

.loop:
	mov al, [ebx] ;store character to be printed in al
	mov ah, WHITE_ON_BLACK ;store color byte in ah

	cmp al, 0 ;check if string terminated
	je .done
	
	mov [edx], ax ;store character and color byte in video memory
	add ebx, 1 ;next character
	add edx, 2 ;next video memory position

	jmp .loop

.done:
	popa
	ret
