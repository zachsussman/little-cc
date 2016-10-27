default rel
extern _exit
extern _printf
section .text
global _main
_main:
	; unknown instruction
	; unknown instruction
	mov rdi, rax
	mov rax, 0x2000001
	syscall
	
section .data
	dummy: dw 16
