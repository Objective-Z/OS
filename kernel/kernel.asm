	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.file	1 "kernel/../cpu" "types.h"
	.file	2 "kernel/../cpu" "idt.h"
	.globl	_kmain
	.p2align	4, 0x90
_kmain:                                 ## @kmain
Lfunc_begin0:
	.file	3 "kernel" "kernel.c"
	.loc	3 6 0                   ## kernel/kernel.c:6:0
	.cfi_sections .debug_frame
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi0:
	.cfi_def_cfa_offset 8
Lcfi1:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi2:
	.cfi_def_cfa_register %ebp
Ltmp0:
	.loc	3 7 2 prologue_end      ## kernel/kernel.c:7:2
	subl	$8, %esp
	calll	_isr_install
	.loc	3 8 2                   ## kernel/kernel.c:8:2
	## InlineAsm Start
	int	$2
	## InlineAsm End
	.loc	3 9 2                   ## kernel/kernel.c:9:2
	## InlineAsm Start
	int3
	## InlineAsm End
	.loc	3 10 1                  ## kernel/kernel.c:10:1
	addl	$8, %esp
	popl	%ebp
	retl
Ltmp1:
Lfunc_end0:
	.cfi_endproc

	.comm	_idt,2048,1             ## @idt
	.comm	_idt_register,6,0       ## @idt_register
	.section	__DWARF,__debug_str,regular,debug
Linfo_string:
	.asciz	"Apple LLVM version 9.0.0 (clang-900.0.39.2)" ## string offset=0
	.asciz	"kernel/kernel.c"       ## string offset=44
	.asciz	"/Users/alexzerphy/assembly/os/operating_system" ## string offset=60
	.asciz	"idt"                   ## string offset=107
	.asciz	"idt_gate_t"            ## string offset=111
	.asciz	"low_offset"            ## string offset=122
	.asciz	"u16"                   ## string offset=133
	.asciz	"unsigned short"        ## string offset=137
	.asciz	"kernel_selector"       ## string offset=152
	.asciz	"always0"               ## string offset=168
	.asciz	"u8"                    ## string offset=176
	.asciz	"unsigned char"         ## string offset=179
	.asciz	"flags"                 ## string offset=193
	.asciz	"high_offset"           ## string offset=199
	.asciz	"sizetype"              ## string offset=211
	.asciz	"idt_register"          ## string offset=220
	.asciz	"idt_register_t"        ## string offset=233
	.asciz	"limit"                 ## string offset=248
	.asciz	"base"                  ## string offset=254
	.asciz	"u32"                   ## string offset=259
	.asciz	"unsigned int"          ## string offset=263
	.asciz	"kmain"                 ## string offset=276
	.section	__DWARF,__debug_loc,regular,debug
Lsection_debug_loc:
	.section	__DWARF,__debug_abbrev,regular,debug
Lsection_abbrev:
	.byte	1                       ## Abbreviation Code
	.byte	17                      ## DW_TAG_compile_unit
	.byte	1                       ## DW_CHILDREN_yes
	.byte	37                      ## DW_AT_producer
	.byte	14                      ## DW_FORM_strp
	.byte	19                      ## DW_AT_language
	.byte	5                       ## DW_FORM_data2
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	16                      ## DW_AT_stmt_list
	.byte	23                      ## DW_FORM_sec_offset
	.byte	27                      ## DW_AT_comp_dir
	.byte	14                      ## DW_FORM_strp
	.byte	17                      ## DW_AT_low_pc
	.byte	1                       ## DW_FORM_addr
	.byte	18                      ## DW_AT_high_pc
	.byte	6                       ## DW_FORM_data4
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	2                       ## Abbreviation Code
	.byte	52                      ## DW_TAG_variable
	.byte	0                       ## DW_CHILDREN_no
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	63                      ## DW_AT_external
	.byte	25                      ## DW_FORM_flag_present
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	2                       ## DW_AT_location
	.byte	24                      ## DW_FORM_exprloc
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	3                       ## Abbreviation Code
	.byte	1                       ## DW_TAG_array_type
	.byte	1                       ## DW_CHILDREN_yes
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	4                       ## Abbreviation Code
	.byte	33                      ## DW_TAG_subrange_type
	.byte	0                       ## DW_CHILDREN_no
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	55                      ## DW_AT_count
	.byte	5                       ## DW_FORM_data2
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	5                       ## Abbreviation Code
	.byte	22                      ## DW_TAG_typedef
	.byte	0                       ## DW_CHILDREN_no
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	6                       ## Abbreviation Code
	.byte	19                      ## DW_TAG_structure_type
	.byte	1                       ## DW_CHILDREN_yes
	.byte	11                      ## DW_AT_byte_size
	.byte	11                      ## DW_FORM_data1
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	7                       ## Abbreviation Code
	.byte	13                      ## DW_TAG_member
	.byte	0                       ## DW_CHILDREN_no
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	56                      ## DW_AT_data_member_location
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	8                       ## Abbreviation Code
	.byte	36                      ## DW_TAG_base_type
	.byte	0                       ## DW_CHILDREN_no
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	62                      ## DW_AT_encoding
	.byte	11                      ## DW_FORM_data1
	.byte	11                      ## DW_AT_byte_size
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	9                       ## Abbreviation Code
	.byte	36                      ## DW_TAG_base_type
	.byte	0                       ## DW_CHILDREN_no
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	11                      ## DW_AT_byte_size
	.byte	11                      ## DW_FORM_data1
	.byte	62                      ## DW_AT_encoding
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	10                      ## Abbreviation Code
	.byte	46                      ## DW_TAG_subprogram
	.byte	0                       ## DW_CHILDREN_no
	.byte	17                      ## DW_AT_low_pc
	.byte	1                       ## DW_FORM_addr
	.byte	18                      ## DW_AT_high_pc
	.byte	6                       ## DW_FORM_data4
	.byte	64                      ## DW_AT_frame_base
	.byte	24                      ## DW_FORM_exprloc
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	63                      ## DW_AT_external
	.byte	25                      ## DW_FORM_flag_present
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	0                       ## EOM(3)
	.section	__DWARF,__debug_info,regular,debug
Lsection_info:
Lcu_begin0:
	.long	276                     ## Length of Unit
	.short	4                       ## DWARF version number
Lset0 = Lsection_abbrev-Lsection_abbrev ## Offset Into Abbrev. Section
	.long	Lset0
	.byte	4                       ## Address Size (in bytes)
	.byte	1                       ## Abbrev [1] 0xb:0x10d DW_TAG_compile_unit
	.long	0                       ## DW_AT_producer
	.short	12                      ## DW_AT_language
	.long	44                      ## DW_AT_name
Lset1 = Lline_table_start0-Lsection_line ## DW_AT_stmt_list
	.long	Lset1
	.long	60                      ## DW_AT_comp_dir
	.long	Lfunc_begin0            ## DW_AT_low_pc
Lset2 = Lfunc_end0-Lfunc_begin0         ## DW_AT_high_pc
	.long	Lset2
	.byte	2                       ## Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	107                     ## DW_AT_name
	.long	55                      ## DW_AT_type
                                        ## DW_AT_external
	.byte	2                       ## DW_AT_decl_file
	.byte	31                      ## DW_AT_decl_line
	.byte	5                       ## DW_AT_location
	.byte	3
	.long	_idt
	.byte	3                       ## Abbrev [3] 0x37:0xd DW_TAG_array_type
	.long	68                      ## DW_AT_type
	.byte	4                       ## Abbrev [4] 0x3c:0x7 DW_TAG_subrange_type
	.long	180                     ## DW_AT_type
	.short	256                     ## DW_AT_count
	.byte	0                       ## End Of Children Mark
	.byte	5                       ## Abbrev [5] 0x44:0xb DW_TAG_typedef
	.long	79                      ## DW_AT_type
	.long	111                     ## DW_AT_name
	.byte	2                       ## DW_AT_decl_file
	.byte	21                      ## DW_AT_decl_line
	.byte	6                       ## Abbrev [6] 0x4f:0x41 DW_TAG_structure_type
	.byte	8                       ## DW_AT_byte_size
	.byte	2                       ## DW_AT_decl_file
	.byte	10                      ## DW_AT_decl_line
	.byte	7                       ## Abbrev [7] 0x53:0xc DW_TAG_member
	.long	122                     ## DW_AT_name
	.long	144                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	11                      ## DW_AT_decl_line
	.byte	0                       ## DW_AT_data_member_location
	.byte	7                       ## Abbrev [7] 0x5f:0xc DW_TAG_member
	.long	152                     ## DW_AT_name
	.long	144                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	12                      ## DW_AT_decl_line
	.byte	2                       ## DW_AT_data_member_location
	.byte	7                       ## Abbrev [7] 0x6b:0xc DW_TAG_member
	.long	168                     ## DW_AT_name
	.long	162                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	13                      ## DW_AT_decl_line
	.byte	4                       ## DW_AT_data_member_location
	.byte	7                       ## Abbrev [7] 0x77:0xc DW_TAG_member
	.long	193                     ## DW_AT_name
	.long	162                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	19                      ## DW_AT_decl_line
	.byte	5                       ## DW_AT_data_member_location
	.byte	7                       ## Abbrev [7] 0x83:0xc DW_TAG_member
	.long	199                     ## DW_AT_name
	.long	144                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	20                      ## DW_AT_decl_line
	.byte	6                       ## DW_AT_data_member_location
	.byte	0                       ## End Of Children Mark
	.byte	5                       ## Abbrev [5] 0x90:0xb DW_TAG_typedef
	.long	155                     ## DW_AT_type
	.long	133                     ## DW_AT_name
	.byte	1                       ## DW_AT_decl_file
	.byte	6                       ## DW_AT_decl_line
	.byte	8                       ## Abbrev [8] 0x9b:0x7 DW_TAG_base_type
	.long	137                     ## DW_AT_name
	.byte	7                       ## DW_AT_encoding
	.byte	2                       ## DW_AT_byte_size
	.byte	5                       ## Abbrev [5] 0xa2:0xb DW_TAG_typedef
	.long	173                     ## DW_AT_type
	.long	176                     ## DW_AT_name
	.byte	1                       ## DW_AT_decl_file
	.byte	8                       ## DW_AT_decl_line
	.byte	8                       ## Abbrev [8] 0xad:0x7 DW_TAG_base_type
	.long	179                     ## DW_AT_name
	.byte	8                       ## DW_AT_encoding
	.byte	1                       ## DW_AT_byte_size
	.byte	9                       ## Abbrev [9] 0xb4:0x7 DW_TAG_base_type
	.long	211                     ## DW_AT_name
	.byte	8                       ## DW_AT_byte_size
	.byte	7                       ## DW_AT_encoding
	.byte	2                       ## Abbrev [2] 0xbb:0x11 DW_TAG_variable
	.long	220                     ## DW_AT_name
	.long	204                     ## DW_AT_type
                                        ## DW_AT_external
	.byte	2                       ## DW_AT_decl_file
	.byte	32                      ## DW_AT_decl_line
	.byte	5                       ## DW_AT_location
	.byte	3
	.long	_idt_register
	.byte	5                       ## Abbrev [5] 0xcc:0xb DW_TAG_typedef
	.long	215                     ## DW_AT_type
	.long	233                     ## DW_AT_name
	.byte	2                       ## DW_AT_decl_file
	.byte	28                      ## DW_AT_decl_line
	.byte	6                       ## Abbrev [6] 0xd7:0x1d DW_TAG_structure_type
	.byte	6                       ## DW_AT_byte_size
	.byte	2                       ## DW_AT_decl_file
	.byte	25                      ## DW_AT_decl_line
	.byte	7                       ## Abbrev [7] 0xdb:0xc DW_TAG_member
	.long	248                     ## DW_AT_name
	.long	144                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	26                      ## DW_AT_decl_line
	.byte	0                       ## DW_AT_data_member_location
	.byte	7                       ## Abbrev [7] 0xe7:0xc DW_TAG_member
	.long	254                     ## DW_AT_name
	.long	244                     ## DW_AT_type
	.byte	2                       ## DW_AT_decl_file
	.byte	27                      ## DW_AT_decl_line
	.byte	2                       ## DW_AT_data_member_location
	.byte	0                       ## End Of Children Mark
	.byte	5                       ## Abbrev [5] 0xf4:0xb DW_TAG_typedef
	.long	255                     ## DW_AT_type
	.long	259                     ## DW_AT_name
	.byte	1                       ## DW_AT_decl_file
	.byte	4                       ## DW_AT_decl_line
	.byte	8                       ## Abbrev [8] 0xff:0x7 DW_TAG_base_type
	.long	263                     ## DW_AT_name
	.byte	7                       ## DW_AT_encoding
	.byte	4                       ## DW_AT_byte_size
	.byte	10                      ## Abbrev [10] 0x106:0x11 DW_TAG_subprogram
	.long	Lfunc_begin0            ## DW_AT_low_pc
Lset3 = Lfunc_end0-Lfunc_begin0         ## DW_AT_high_pc
	.long	Lset3
	.byte	1                       ## DW_AT_frame_base
	.byte	85
	.long	276                     ## DW_AT_name
	.byte	3                       ## DW_AT_decl_file
	.byte	6                       ## DW_AT_decl_line
                                        ## DW_AT_external
	.byte	0                       ## End Of Children Mark
	.section	__DWARF,__debug_ranges,regular,debug
Ldebug_range:
	.section	__DWARF,__debug_macinfo,regular,debug
Ldebug_macinfo:
Lcu_macro_begin0:
	.byte	0                       ## End Of Macro List Mark
	.section	__DWARF,__apple_names,regular,debug
Lnames_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	3                       ## Header Bucket Count
	.long	3                       ## Header Hash Count
	.long	12                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	1                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.long	-1                      ## Bucket 0
	.long	0                       ## Bucket 1
	.long	2                       ## Bucket 2
	.long	265072117               ## Hash in Bucket 1
	.long	530433418               ## Hash in Bucket 1
	.long	193494758               ## Hash in Bucket 2
	.long	LNames0-Lnames_begin    ## Offset in Bucket 1
	.long	LNames2-Lnames_begin    ## Offset in Bucket 1
	.long	LNames1-Lnames_begin    ## Offset in Bucket 2
LNames0:
	.long	276                     ## kmain
	.long	1                       ## Num DIEs
	.long	262
	.long	0
LNames2:
	.long	220                     ## idt_register
	.long	1                       ## Num DIEs
	.long	187
	.long	0
LNames1:
	.long	107                     ## idt
	.long	1                       ## Num DIEs
	.long	38
	.long	0
	.section	__DWARF,__apple_objc,regular,debug
Lobjc_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	1                       ## Header Bucket Count
	.long	0                       ## Header Hash Count
	.long	12                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	1                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.long	-1                      ## Bucket 0
	.section	__DWARF,__apple_namespac,regular,debug
Lnamespac_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	1                       ## Header Bucket Count
	.long	0                       ## Header Hash Count
	.long	12                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	1                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.long	-1                      ## Bucket 0
	.section	__DWARF,__apple_types,regular,debug
Ltypes_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	8                       ## Header Bucket Count
	.long	8                       ## Header Hash Count
	.long	20                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	3                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.short	3                       ## DW_ATOM_die_tag
	.short	5                       ## DW_FORM_data2
	.short	4                       ## DW_ATOM_type_flags
	.short	11                      ## DW_FORM_data1
	.long	0                       ## Bucket 0
	.long	1                       ## Bucket 1
	.long	3                       ## Bucket 2
	.long	-1                      ## Bucket 3
	.long	-1                      ## Bucket 4
	.long	5                       ## Bucket 5
	.long	-1                      ## Bucket 6
	.long	7                       ## Bucket 7
	.long	-104093792              ## Hash in Bucket 0
	.long	193506081               ## Hash in Bucket 1
	.long	-189758535              ## Hash in Bucket 1
	.long	5863826                 ## Hash in Bucket 2
	.long	878862258               ## Hash in Bucket 2
	.long	2116377789              ## Hash in Bucket 5
	.long	-1304652851             ## Hash in Bucket 5
	.long	193506143               ## Hash in Bucket 7
	.long	Ltypes4-Ltypes_begin    ## Offset in Bucket 0
	.long	Ltypes5-Ltypes_begin    ## Offset in Bucket 1
	.long	Ltypes0-Ltypes_begin    ## Offset in Bucket 1
	.long	Ltypes7-Ltypes_begin    ## Offset in Bucket 2
	.long	Ltypes6-Ltypes_begin    ## Offset in Bucket 2
	.long	Ltypes1-Ltypes_begin    ## Offset in Bucket 5
	.long	Ltypes2-Ltypes_begin    ## Offset in Bucket 5
	.long	Ltypes3-Ltypes_begin    ## Offset in Bucket 7
Ltypes4:
	.long	179                     ## unsigned char
	.long	1                       ## Num DIEs
	.long	173
	.short	36
	.byte	0
	.long	0
Ltypes5:
	.long	133                     ## u16
	.long	1                       ## Num DIEs
	.long	144
	.short	22
	.byte	0
	.long	0
Ltypes0:
	.long	111                     ## idt_gate_t
	.long	1                       ## Num DIEs
	.long	68
	.short	22
	.byte	0
	.long	0
Ltypes7:
	.long	176                     ## u8
	.long	1                       ## Num DIEs
	.long	162
	.short	22
	.byte	0
	.long	0
Ltypes6:
	.long	137                     ## unsigned short
	.long	1                       ## Num DIEs
	.long	155
	.short	36
	.byte	0
	.long	0
Ltypes1:
	.long	233                     ## idt_register_t
	.long	1                       ## Num DIEs
	.long	204
	.short	22
	.byte	0
	.long	0
Ltypes2:
	.long	263                     ## unsigned int
	.long	1                       ## Num DIEs
	.long	255
	.short	36
	.byte	0
	.long	0
Ltypes3:
	.long	259                     ## u32
	.long	1                       ## Num DIEs
	.long	244
	.short	22
	.byte	0
	.long	0

.subsections_via_symbols
	.section	__DWARF,__debug_line,regular,debug
Lsection_line:
Lline_table_start0:
