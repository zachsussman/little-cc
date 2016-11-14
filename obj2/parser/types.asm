default rel
section .text

_type_new_base:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 0
	push rax
	mov rax, qword [g1]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_1
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	mov rax, g1
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [g1]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [g1]
	add rax, 8
	pop rcx
	mov [rax], rcx
label_1:
	mov rax, 0
	push rax
	mov rax, qword [g2]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_2
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	mov rax, g2
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [g2]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [g2]
	add rax, 8
	pop rcx
	mov [rax], rcx
label_2:
	mov rax, 0
	push rax
	mov rax, qword [g3]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_3
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	mov rax, g3
	pop rcx
	mov [rax], rcx
	mov rax, 2
	push rax
	mov rax, qword [g3]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [g3]
	add rax, 8
	pop rcx
	mov [rax], rcx
label_3:
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_4
	mov rax, qword [g1]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_5
label_4:
	mov rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_6
	mov rax, qword [g2]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_7
label_6:
	mov rax, 2
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_8
	mov rax, qword [g3]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_9
label_8:
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
	pop rdi
	mov al, 0
	call _exit
label_9:
label_7:
label_5:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_new_pointer:
	sub rsp, 8
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
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_pointer_inner:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_new_struct:
	sub rsp, 8
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
	mov rax, 5
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 32
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 5
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_add_field:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 61
	push rax
	mov rax, _string_3
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_2
	push rax
	mov rax, 62
	push rax
	mov rax, _string_4
	push rax
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	add rax, 0
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	mov rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	pop rcx
	add rax, rcx
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_type_get_field:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 75
	push rax
	mov rax, _string_3
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_2
	push rax
	mov rax, 76
	push rax
	mov rax, _string_4
	push rax
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_new_undet_struct:
	sub rsp, 8
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
	mov rax, 6
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_new_undet:
	sub rsp, 8
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
	mov rax, 7
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_type_print:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 99
	push rax
	mov rax, _string_5
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
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
	cmp rax, 2
	je switch_0_case_2
	cmp rax, 3
	je switch_0_case_3
	cmp rax, 6
	je switch_0_case_4
	cmp rax, 7
	je switch_0_case_5
	jmp switch_0_default
switch_0_case_0:
	mov rax, _string_6
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
switch_0_case_1:
	mov rax, _string_7
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
switch_0_case_2:
	mov rax, _string_8
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
switch_0_case_3:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _type_pointer_inner
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_9
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
switch_0_case_4:
	mov rax, _string_10
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
switch_0_case_5:
	mov rax, _string_11
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
switch_0_default:
	mov rax, _string_12
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_10
label_10:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	g3: dq 0
	g1: dq 0
	g2: dq 0
	_string_7: db 118, 111, 105, 100, 0
	_string_2: db 112, 97, 114, 115, 101, 114, 47, 116, 121, 112, 101, 115, 46, 99, 0
	_string_6: db 105, 110, 116, 0
	_string_4: db 115, 45, 62, 98, 97, 115, 101, 32, 61, 61, 32, 76, 65, 78, 71, 95, 83, 84, 82, 85, 67, 84, 0
	_string_9: db 42, 0
	_string_8: db 99, 104, 97, 114, 0
	_string_1: db 85, 110, 107, 110, 111, 119, 110, 32, 116, 121, 112, 101, 32, 37, 105, 10, 0
	_string_3: db 115, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_10: db 115, 116, 114, 117, 99, 116, 32, 37, 115, 0
	_string_5: db 118, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_11: db 37, 115, 0
	_string_12: db 84, 89, 80, 69, 95, 85, 78, 75, 78, 79, 87, 78, 0
extern _fprintf
extern _hash_insert
extern _strdup
global _type_add_field
extern _hash_get
extern _my_assert
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
global _type_get_field
extern _queue_test
extern _fclose
extern _getline
extern _free
global _type_new_pointer
extern _type_new_fn
extern _strndup
extern _hash_new
extern _token_delete
extern _queue_length
extern _peek
global _type_print
extern _types_init
extern _hash_in
extern _queue_free
global _type_pointer_inner
extern _queue_empty
global _type_new_base
extern _hash_do_over
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
extern _printf
global _type_new_undet
global _type_new_undet_struct
extern _str_token_type
global _type_new_struct
extern _strcmp
extern _enq
extern _token_new
extern _exit
