default rel
extern _exit
extern _printf
extern _malloc
section .text
global _main

_main:
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 8
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	lea rax, [rbp+8]
	pop rcx
	mov [rax], rcx
	mov rax, 10
	push rax
	mov rax, qword [rbp+8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 20
	push rax
	mov rax, qword [rbp+8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, _string_0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	add rsp, 8
	pop rbp
	add rsp, 8
	ret
	
section .data
	dummy: dw 16
	_string_0: db 37, 105, 10, 0
