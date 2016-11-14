default rel
section .text

_type_get_size:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	cmp rax, 0
	je switch_0_case_0
	cmp rax, 1
	je switch_0_case_1
	cmp rax, 3
	je switch_0_case_2
	cmp rax, 2
	je switch_0_case_3
	jmp switch_0_default
switch_0_case_0:
switch_0_case_1:
switch_0_case_2:
	mov rax, 8
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
switch_0_case_3:
	mov rax, 1
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
switch_0_default:
label_1:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_main:
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_get_size
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rsp, rbp
	pop rbp
	add rsp, 0
	ret
	
section .data
	dummy: dw 16
	_string_1: db 37, 100, 10, 0
global _main
global _type_get_size
extern _printf
