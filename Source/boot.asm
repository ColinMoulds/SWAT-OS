;boot.asm:the bootloader to boot are operating system with grub
[bits 32] ;we are in 32 bit
global start ;start's the operating system:we call it in the linker script
extern _kernel_main ;this is in are .cpp file and it is the main function of are kernel
;do not modify these lines(these are needed by grub)!
section .mbHeader

align 0x4
 
; setting up the Multiboot header - see GRUB docs for details
MODULEALIGN equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
FLAGS       equ  MODULEALIGN | MEMINFO  ; this is the Multiboot 'flag' field
MAGIC       equ    0x1BADB002           ; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum required
 
MultiBootHeader:
   dd MAGIC
   dd FLAGS
   dd CHECKSUM
 
;you can modify these
start:
push ebx ;this is optional and load's the grub structure
call _kernel_main