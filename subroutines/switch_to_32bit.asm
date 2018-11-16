[bits 16]
switch_to_prot:
	cli ;disable interrupts
	lgdt [gdt_descriptor] ;load GDT descriptor
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax ;set protected mode bit in cr0
	jmp CODE_SEG:init_prot ;far jump using a different segment

[bits 32]
init_prot:
	mov ax, DATA_SEG ;update segment registers
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000 ;update the stack at top of free space
	mov esp, ebp

	call BEGIN_PROT ;begin 32-bit protected mode
