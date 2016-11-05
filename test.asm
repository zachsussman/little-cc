default rel
section .text

_main:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	add rsp, 16
	pop rbp
	add rsp, 0
	ret
	
section .data
	dummy: dw 16
extern _printf
extern _strncmp
global _main
