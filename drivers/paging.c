#include "paging.h"

page_dir_t* kernel_dir = 0;
page_dir_t* current_dir = 0;

u32* frames; //bitset of frames
u32 nframes;

extern u32 placement_address; //defined in kheap.c
extern heap_t* kheap;

//macros for bitset algorithm
#define INDEX_FROM_BIT(a) (a / (8 * 4))
#define OFFSET_FROM_BIT(a) (a % (8 * 4))

/* purpose:
 * 	sets a bit in the "frames" bitset.
 * input:
 * 	the frame address.
 * output:
 * 	void
 * processing:
 * 	determines the frame number.
 *	determines the bit index.
 *	determines the bit offset.
 *	sets the bit.
 */
static void set_frame(u32 frame_addr){
	u32 frame = frame_addr / 0x1000;
	u32 index = INDEX_FROM_BIT(frame);
	u32 offset = OFFSET_FROM_BIT(frame);
	frames[index] |= (0x1 << offset);
}

/* purpose:
 * 	clear a bit in the "frames" bitset.
 * input:
 * 	the frame address.
 * output:
 * 	void
 * processing:
 * 	see set_frame.
 */
static void clear_frame(u32 frame_addr){
	u32 frame = frame_addr / 0x1000;
	u32 index = INDEX_FROM_BIT(frame);
	u32 offset = OFFSET_FROM_BIT(frame);
	frames[index] &= ~(0x1 << offset);
}

/* purpose:
 * 	tests if bit is set.
 * input:
 * 	the frame address.
 * output:
 * 	1 if bit is set, 0 otherwise.
 * processing:
 * 	see set_frame
 */
static u32 test_frame(u32 frame_addr){
	u32 frame = frame_addr / 0x1000;
	u32 index = INDEX_FROM_BIT(frame);
	u32 offset = OFFSET_FROM_BIT(frame);
	return frames[index] & (0x1 << offset);
}

/* purpose:
 * 	find the first free frame.
 * input:
 * 	void
 * output:
 * 	the number of the first free frame.
 * processing:
 * 	...
 */
static u32 first_frame(){
	u32 i, j;
	for (i = 0; i < INDEX_FROM_BIT(nframes); i++){
		if (frame[i] != 0xffffffff){
			for (j = 0; j < 32; j++){
				u32 test = 0x1 << j;
				if (!(frames[i] & test)){
					return i * 8 * 4 + j;
				}
			}
		}
	}
}

/* purpose: 
 * 	allocates a frame
 * input: 
 * 	page: pointer to the current page.
 * 	is_kernel: 1 if frame is allocated for the kernel,
 * 		0 otherwise.
 *	is_writable: 1 if frame is writable, 0 if readonly.
 * output:
 * 	void
 * processing:
 * 	checks if frame was already allocated and, if it was, returns 
 * 		immediately.
 * 	if a frame was not already allocated, finds the index of the
 * 		first free frame.
 * 	checks if the index is 0xffffffff (i.e. no free frames) and
 * 		, if so, returns an error.
 *	sets frame address and all page information (i.e. is the page
 *		present, is it writable, etc.)
 */
void alloc_frame(page_t* page, int is_kernel, int is_writable){
	if (page -> frame != 0){
		return;
	}
	else{
		u32 index = first_frame();
		if (index == (u32) -1){
			PANIC("No free frames!");
		}
		set_frame(index * 0x1000);
		page -> present = 1;
		page -> rw = is_writable ? 1 : 0;
		page -> user = is_kernel ? 0 : 1;
		page -> frame = index;
	}
}

void free_frame(page_t* page){
	u32 frame;
	if (!(frame = (page -> frame))){
		return;
	}
	else{
		clear_frame(frame);
		page -> frame = 0x0;
	}
}

void init_paging(){
	u32 mem_page_end = 0x1000000;
	nframes = mem_page_end / 0x1000;
	frames = (u32*) kmalloc(INDEX_FROM_BIT(nframes));
	memory_set(kernel_dir, 0, sizeof(page_dir_t));
	current_dir = kernel_dir;

	int i = 0;
	while (i < placement_address){
		alloc_frame(get_page(i, 1, kernel_dir), 0, 0);
		i += 0x1000;
	}

	register_interrupt_handler(14, page_fault);
	switch_page_dir(kernel_dir);
}

void switch_page_dir(page_dir_t* dir){
	current_dir = dir;
	asm volatile("mov %0, %%cr3" : : "r" (&dir -> tablesPhys));
	u32 cr0;
	asm volatile("mov %%cr0, %0" : "=r" (cr0));
	cr0 |= 0x80000000;
	asm volatile("mov %0, %%cr0" : : "r" (cr0));
}

page_t* get_page(u32 addr, int make, page_dir_t* dir){
	addr /= 0x1000;
	u32 table_index = addr / 1024;
	if (dir -> tables[table_index]){
		return &dir -> tables[table_index] -> pages[addr % 1024];
	}
	else if (make){
		u32 tmp;
		dir -> tables[table_index] = (page_table_t*) kmalloc_aphys(sizeof(page_table_t), &tmp);
		memory_set(dir -> tables[table_index], 0, 0x1000);
		dir -> tablesPhys[table_index] = tmp | 0x7;
		return &dir -> tables[table_index] -> pages[addr % 1024];
	}
	else{
		return 0;
	}
}

void page_fault(registers_t regs){
	u32 fault_addr;
	asm volatile("mov %%cr2, %0" : "=r" (fault_addr));

	int present = !(regs.err_code & 0x1);
	int rw = regs.err_code & 0x2;
	int us = regs.err_code & 0x4;
	int reserved = regs.err_code & 0x8;
	int id = regs.err_code & 0x10;

	kprint("Page fault! (");
	if (present){
		kprint("present ");
	}
	if (rw){
		kprint("read-only ");
	}
	if (us){
		kprint("user-mode ");
	}
	if (reserved){
		kprint("reserved ");
	}
	kprint(") at 0x");
	kprint(fault_addr);
	kprint_newline();
	PANIC("Page fault");
}
