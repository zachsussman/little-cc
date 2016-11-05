default rel
extern _exit
extern _printf
extern _malloc
section .text
global _main

_is_token:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_1
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_1:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_token_new:
	sub rsp, 8
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
