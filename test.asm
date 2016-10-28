default rel
extern _exit
extern _printf
section .text
global _main

_factorial:
	push rdi
	push rbp
	mov rbp, rsp
	mov rax, 2
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_0
	mov rax, _string_0
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	pop rbp
	add rsp, 8
	ret
	jmp label_1
label_0:
	mov rax, _string_1
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	sub rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _factorial
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	mul rcx
	pop rbp
	add rsp, 8
	ret
label_1:
	pop rbp
	add rsp, 8
	ret
_main:
	push rbp
	mov rbp, rsp
	mov rax, _string_2
	push rax
	mov rax, 10
	push rax
	pop rdi
	mov al, 0
	call _factorial
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rbp
	add rsp, 0
	ret
	mov rdi, rax
	mov rax, 0x2000001
	syscall
	
section .data
	dummy: dw 16
	_string_2: db 102, 97, 99, 116, 111, 114, 105, 97, 108, 40, 49, 48, 41, 58, 32, 37, 105, 10, 0
	_string_1: db 82, 101, 99, 117, 114, 115, 105, 118, 101, 58, 32, 37, 105, 10, 0
	_string_0: db 66, 97, 115, 101, 32, 99, 97, 115, 101, 58, 32, 37, 105, 10, 0
