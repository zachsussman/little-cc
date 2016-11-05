default rel
extern _exit
extern _printf
extern _malloc
section .text
global _main

_token_new:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
