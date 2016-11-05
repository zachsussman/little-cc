default rel
section .text

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
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_is_dynamic_token:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_5
	mov rax, 1
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_5:
	test rax, rax
	jnz label_4
	mov rax, 2
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_4:
	test rax, rax
	jnz label_3
	mov rax, 3
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_3:
	test rax, rax
	jnz label_2
	mov rax, 50
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_2:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_token_delete:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_dynamic_token
	cmp rax, 0
	je label_6
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _free
label_6:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _free
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_str_token_type:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	cmp rax, 0
	je switch_0_case_0
	cmp rax, 1
	je switch_0_case_1
	cmp rax, 34
	je switch_0_case_34
	cmp rax, 50
	je switch_0_case_50
	jmp switch_0_default
switch_0_case_0:
	mov rax, _string_1
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_case_1:
	mov rax, _string_2
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_case_34:
	mov rax, _string_3
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_case_50:
	mov rax, _string_4
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_default:
	mov rax, _string_5
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_7
label_7:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_5: db 83, 89, 77, 66, 79, 76, 0
	_string_4: db 79, 84, 72, 69, 82, 0
	_string_2: db 78, 85, 77, 66, 69, 82, 0
	_string_3: db 75, 87, 0
	_string_1: db 78, 65, 77, 69, 0
global _token_delete
extern _getline
extern _calloc
extern _printf
extern _strncmp
global _str_token_type
extern _exit
extern _strcmp
global _is_dynamic_token
extern _fopen
extern _free
extern _malloc
global _is_token
global _token_new
