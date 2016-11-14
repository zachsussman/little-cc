default rel
section .text

_is_scope:
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
	jz label_3
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_3:
	test rax, rax
	jz label_2
	mov rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+0]
	pop rcx
	mul rcx
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_2:
	test rax, rax
	jz label_1
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+24]
	pop rcx
	cmp rax, rcx
	setge al
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
_scope_new:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 11
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_scope
	test rax, rax
	jnz label_4
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_4:
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 32
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 10
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 24
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
_scope_get_next_index:
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
	sete al
	movzx rax, al
	cmp rax, 0
	je label_5
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_6
label_5:
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _scope_get_next_index
	pop rcx
	add rax, rcx
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_6:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_scope_add_count:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
label_7:
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_8
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+24]
	pop rcx
	add rax, rcx
	push rax
	mov rax, qword [rbp+8]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	lea rax, [rbp+8]
	pop rcx
	mov [rax], rcx
	jmp label_7
label_8:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_scope_add_local:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_9
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
label_9:
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 2
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _scope_get_next_index
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rax, 8
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	push rax
	mov rax, qword [rbp+8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _scope_add_count
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_scope_find_local:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_10
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_10:
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	mov [rbp-8], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_11
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _scope_find_local
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_12
label_11:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_12:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_2: db 105, 115, 95, 115, 99, 111, 112, 101, 40, 112, 97, 114, 101, 110, 116, 41, 32, 124, 124, 32, 112, 97, 114, 101, 110, 116, 32, 61, 61, 32, 78, 85, 76, 76, 0
	_string_1: db 112, 97, 114, 115, 101, 114, 47, 115, 99, 111, 112, 101, 46, 99, 0
extern _fprintf
global _scope_get_next_index
extern _hash_insert
extern _strdup
extern _type_add_field
extern _hash_get
extern _my_assert
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
global _scope_add_local
extern _type_get_field
extern _queue_test
extern _fclose
extern _getline
extern _free
extern _type_new_pointer
extern _type_new_fn
extern _strndup
extern _hash_new
extern _token_delete
extern _queue_length
global _scope_new
extern _peek
global _scope_add_count
extern _type_print
extern _types_init
extern _hash_in
extern _queue_free
extern _type_pointer_inner
global _is_scope
extern _queue_empty
extern _type_new_base
extern _hash_do_over
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
extern _printf
global _scope_find_local
extern _type_new_undet
extern _type_new_undet_struct
extern _str_token_type
extern _type_new_struct
extern _strcmp
extern _enq
extern _token_new
extern _exit
