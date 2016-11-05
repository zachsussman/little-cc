default rel
extern _exit
extern _printf
extern _malloc
section .text
global _main

_main:
	sub rsp, 8
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov rax, _string_1
	push rax
	mov rax, 42
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov al, 0
	call _queue_new
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	cmp rax, 0
	je label_1
	mov rax, 1
	imul rax, 8
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_2
label_1:
	mov rax, _string_2
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
label_2:
	mov rax, qword [rbp-24]
	push rax
	mov rax, _string_3
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fopen
	mov [rbp-32], rax
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _write_header
	mov al, 0
	call _env_new
	mov [rbp-40], rax
	mov rax, _string_4
	push rax
	pop rdi
	mov al, 0
	call _printf
label_3:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_4
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _parse_line
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_3
label_4:
label_5:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_6
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _parse
	mov [rbp-48], rax
	mov rax, qword [rbp-48]
	push rax
	pop rdi
	mov al, 0
	call _print_node
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-48]
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	jmp label_5
label_6:
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _write_footer
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _fclose
	mov rax, 0
	add rsp, 48
	pop rbp
	add rsp, 16
	ret
	add rsp, 48
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_3: db 119, 0
	_string_2: db 116, 101, 115, 116, 46, 97, 115, 109, 0
	_string_4: db 65, 108, 108, 111, 99, 97, 116, 101, 100, 32, 101, 39, 114, 121, 116, 104, 105, 110, 103, 10, 0
	_string_1: db 37, 105, 10, 0
