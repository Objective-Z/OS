;load dh sectors from drive dl into es:bx
disk_load:
	pusha
	push dx
	mov ah, 0x02 ;read mode
	mov al, dh ;al = number of sectors to read
	mov cl, 0x02 ;cl = sector number.  0x01 is boot sector
	mov ch, 0x00 ;cylinder number
	;dl is drive number.  caller sets as parameter and gets it from the BIOS
	mov dh, 0x00 ;dh = head number
	
	;[es:bx] = pointer to buffer where data will be stored
	;caller sets it for us and it is the standard location for int 0x13
	int 0x13 ;BIOS interrupt for disk I/O operations
	jc disk_error

	pop dx
	cmp al, dh
	jne sectors_error
	popa
	ret

disk_error:
	mov bx, DISK_ERROR
	call print_string
	call newline
	mov dh, ah ;ah = error code, dl = disk that raised the error
	call print_hex
	jmp disk_loop

sectors_error:
	mov bx, SECTORS_ERROR
	call print_string
	
disk_loop:
	jmp $

DISK_ERROR: db "Disk read error...", 0
SECTORS_ERROR: db "Incorrect number of sectors read...", 0
