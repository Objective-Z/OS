[extern handler]
[extern irq_handler]

;isr common stub
common_stub:
	pusha
	mov ax, ds
	push eax
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	call handler
	
	pop eax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	popa
	add esp, 8
	sti
	iret

;irq common stub
irq_common_stub:
	pusha
	mov ax, ds
	push eax
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	call irq_handler
	pop ebx
	mov ds, bx
	mov es, bx
	mov fs, bx
	mov gs, bx
	popa
	add esp, 8
	sti
	iret

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

global irq0
global irq1
global irq2
global irq3
global irq4
global irq5
global irq6
global irq7
global irq8
global irq9
global irq10
global irq11
global irq12
global irq13
global irq14
global irq15

;divide by zero exception
isr0:
	cli
	push byte 0
	push byte 0
	jmp common_stub

;debug exception
isr1:
	cli
	push byte 0
	push byte 1
	jmp common_stub

;non-maskable interrupt exception
isr2:
	cli
	push byte 0
	push byte 2
	jmp common_stub

;int 3 exception
isr3:
        cli
        push byte 0
        push byte 3
        jmp common_stub

;into exception
isr4:
        cli
        push byte 0
        push byte 4
        jmp common_stub

;out of bounds exception
isr5:
        cli
        push byte 0
        push byte 5
        jmp common_stub

;invalid opcode exception
isr6:
        cli
        push byte 0
        push byte 6
        jmp common_stub

;coprocessor not available exception
isr7:
        cli
        push byte 0
        push byte 7
        jmp common_stub

;double fault exception + error code
isr8:
        cli
        push byte 8
        jmp common_stub

;coprocessor segment overrun exception
isr9:
        cli
        push byte 0
        push byte 9
        jmp common_stub

;bad TSS exception + error code
isr10:
        cli
        push byte 10
        jmp common_stub

;segment not present exception + error code
isr11:
        cli
        push byte 11
        jmp common_stub

;stack fault exception + error code
isr12:
        cli
        push byte 12
        jmp common_stub

;general protection fault exception + error code
isr13:
        cli
        push byte 13
        jmp common_stub

;page fault exception + error code
isr14:
        cli
        push byte 14
        jmp common_stub

;reserved exception
isr15:
        cli
        push byte 0
        push byte 15
        jmp common_stub

;floating point exception
isr16:
        cli
        push byte 0
        push byte 16
        jmp common_stub

;alignment check exception
isr17:
        cli
        push byte 0
        push byte 17
        jmp common_stub

;machine check exception
isr18:
        cli
        push byte 0
        push byte 18
        jmp common_stub

;reserved
isr19:
        cli
        push byte 0
        push byte 19
        jmp common_stub

;reserved
isr20:
        cli
        push byte 0
        push byte 20
        jmp common_stub

;reserved
isr21:
        cli
        push byte 0
        push byte 21
        jmp common_stub

;reserved
isr22:
        cli
        push byte 0
        push byte 22
        jmp common_stub

;reserved
isr23:
        cli
        push byte 0
        push byte 23
        jmp common_stub

;reserved
isr24:
        cli
        push byte 0
        push byte 24
        jmp common_stub

;reserved
isr25:
        cli
        push byte 0
        push byte 25
        jmp common_stub

;reserved
isr26:
        cli
        push byte 0
        push byte 26
        jmp common_stub

;reserved
isr27:
        cli
        push byte 0
        push byte 27
        jmp common_stub

;reserved
isr28:
        cli
        push byte 0
        push byte 28
        jmp common_stub

;reserved
isr29:
        cli
        push byte 0
        push byte 29
        jmp common_stub

;reserved
isr30:
        cli
        push byte 0
        push byte 30
        jmp common_stub

;reserved
isr31:
        cli
        push byte 0
        push byte 31
        jmp common_stub

;irq handlers
irq0:
	cli
	push byte 0
	push byte 32
	jmp irq_common_stub

irq1:
        cli
        push byte 1
        push byte 33
        jmp irq_common_stub

irq2:
        cli
        push byte 2
        push byte 34
        jmp irq_common_stub

irq3:
        cli
        push byte 3
        push byte 35
        jmp irq_common_stub

irq4:
        cli
        push byte 4
        push byte 36
        jmp irq_common_stub

irq5:
        cli
        push byte 5
        push byte 37
        jmp irq_common_stub

irq6:
        cli
        push byte 6
        push byte 38
        jmp irq_common_stub

irq7:
        cli
        push byte 7
        push byte 39
        jmp irq_common_stub

irq8:
        cli
        push byte 8
        push byte 40
        jmp irq_common_stub

irq9:
        cli
        push byte 9
        push byte 41
        jmp irq_common_stub

irq10:
        cli
        push byte 10
        push byte 42
        jmp irq_common_stub

irq11:
        cli
        push byte 11
        push byte 43
        jmp irq_common_stub

irq12:
        cli
        push byte 12
        push byte 44
        jmp irq_common_stub

irq13:
        cli
        push byte 13
        push byte 45
        jmp irq_common_stub

irq14:
        cli
        push byte 14
        push byte 46
        jmp irq_common_stub

irq15:
        cli
        push byte 15
        push byte 47
        jmp irq_common_stub
