default rel
section .text

_is_token:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_token_new:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
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
	mov rax, _string_1
	push rax
	mov rax, 14
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_token
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_is_dynamic_token:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rax, 51
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_2:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_token_delete:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 24
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_token
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_str_token_type:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 30
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_token
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	cmp rax, 0
	je switch_0_case_0
	cmp rax, 1
	je switch_0_case_1
	cmp rax, 35
	je switch_0_case_2
	cmp rax, 51
	je switch_0_case_3
	jmp switch_0_default
switch_0_case_0:
	mov rax, _string_3
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_case_1:
	mov rax, _string_4
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_case_2:
	mov rax, _string_5
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_case_3:
	mov rax, _string_6
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_7
switch_0_default:
	mov rax, _string_7
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_7
label_7:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_6: db 79, 84, 72, 69, 82, 0
	_string_4: db 78, 85, 77, 66, 69, 82, 0
	_string_3: db 78, 65, 77, 69, 0
	_string_7: db 83, 89, 77, 66, 79, 76, 0
	_string_5: db 75, 87, 0
	_string_2: db 105, 115, 95, 116, 111, 107, 101, 110, 40, 84, 41, 0
	_string_1: db 116, 111, 107, 101, 110, 105, 122, 101, 114, 47, 116, 111, 107, 101, 110, 115, 46, 99, 0
extern _fprintf
extern _strdup
extern _my_assert
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
global _is_dynamic_token
global _is_token
extern _fclose
extern _getline
extern _free
extern _strndup
global _token_delete
extern _fopen
extern _printf
global _str_token_type
extern _strcmp
global _token_new
extern _exit
