C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o} 

# Change this if your cross-compiler is somewhere else
CC = gcc
GDB = gdb
# -g: Use debugging symbols in gcc
CFLAGS = -g 

# First rule is run by default
os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.bin

cpu/interrupt.o: cpu/interrupt.asm
	nasm -f elf -o $@ $^

# '--oformat binary' deletes all symbols as a collateral, so we don't need
# to 'strip' them manually on this case
kernel.bin: subroutines/kernel_entry.o drivers/initrd.o ${OBJ}
	ld -e kmain -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

drivers/initrd.elf: kernel/util.o drivers/ports.o drivers/screen.o drivers/filesystem.o drivers/initrd.o
	ld -m elf_i386 -o $@ $^

# Used for debugging purposes
kernel.elf: subroutines/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ 

boot/bootsect.bin: boot/bootsect.asm
	nasm -f bin -o $@ $^

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin -d guest_errors,int &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -m32 -fno-pie -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf32 -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o cpu/*.o
