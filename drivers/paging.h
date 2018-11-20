#include "../kernel/util.h"
#include "../cpu/isr.h"
#include "screen.h"

typedef struct page{
	u32 present: 1;
	u32 rw: 1;
	u32 user: 1;
	u32 accessed: 1;
	u32 dirty: 1;
	u32 unused: 7;
	u32 frame: 20;
} page_t;

typedef struct page_table{
	page_t pages[1024];
} page_table_t

typedef struct page_dir{
	page_table_t* tables[1024];
	u32 tablesPhys[1024];
	u32 physaddr;
} page_dir_t;

void init_paging();
void switch_page_dir(page_dir_t* new_dir);
page_t* get_page(u32 address, int make, page_dir_t* dir);
void page_fault(registers_t regs);
