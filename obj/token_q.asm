default rel
extern _exit
extern _printf
extern _malloc
section .text
global _main

_token_enq:
	sub rsp, 8
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_token_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	mov [rbp-8], rax
	mov rax, _string_1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_token_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _peek
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_1: db 37, 115, 32, 0
