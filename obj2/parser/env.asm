default rel
section .text

_max:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	cmp rax, 0
	je label_1
	mov rax, qword [rbp+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_2
label_1:
	mov rax, qword [rbp+16]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_2:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_global_var:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	add rax, 8
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
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
_new_arg_var:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
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
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	push rax
	mov rax, 8
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _max
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	add rax, rcx
	push rax
	mov rax, qword [rbp+16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_local_var:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
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
	mov rax, qword [rbp+16]
	mov rax, [rax+32]
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	push rax
	mov rax, 8
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _max
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+32]
	pop rcx
	add rax, rcx
	push rax
	mov rax, qword [rbp+16]
	add rax, 32
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_const_var:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
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
_new_fn_info:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 40
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 5
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 32
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
_new_fn_reg_info:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 40
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 5
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _scope_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 1
	neg rax
	push rax
	mov rax, qword [rbp-8]
	add rax, 32
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
_is_env:
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
	mov rax, [rax+16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_3:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_new:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 104
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 32
	pop rcx
	mov [rax], rcx
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 48
	pop rcx
	mov [rax], rcx
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 56
	pop rcx
	mov [rax], rcx
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 64
	pop rcx
	mov [rax], rcx
	mov al, 0
	call _stack_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 80
	pop rcx
	mov [rax], rcx
	mov al, 0
	call _queue_new
	push rax
	mov rax, qword [rbp-8]
	add rax, 88
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 96
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	add rax, 72
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 40
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 88
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
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
	add rsp, 0
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 0
	ret
_env_get_string:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 93
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+32]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_4
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+32]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	add rax, 24
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
label_4:
	mov rax, qword [rbp+8]
	mov rax, [rax+32]
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
_env_add_global:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 104
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_global_var
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rax, _string_1
	push rax
	mov rax, 110
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_env_get_info:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 114
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	test rax, rax
	jz label_6
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
label_6:
	cmp rax, 0
	je label_5
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
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
	jmp label_7
label_5:
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+40]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_9
	mov rax, qword [rbp+8]
	mov rax, [rax+40]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _scope_find_local
label_9:
	cmp rax, 0
	je label_8
	mov rax, qword [rbp+8]
	mov rax, [rax+40]
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
	jmp label_10
label_8:
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	cmp rax, 0
	je label_11
	mov rax, qword [rbp+8]
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
	jmp label_12
label_11:
	mov rax, _string_3
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, _string_1
	push rax
	mov rax, 124
	push rax
	mov rax, _string_4
	push rax
	mov rax, 0
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
label_12:
label_10:
label_7:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_set_fn:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 130
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
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
	je label_13
	mov rax, _string_5
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, _string_1
	push rax
	mov rax, 134
	push rax
	mov rax, _string_4
	push rax
	mov rax, 0
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	jmp label_14
label_13:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	add rax, 0
	pop rcx
	mov [rax], rcx
label_14:
	mov rax, _string_1
	push rax
	mov rax, 141
	push rax
	mov rax, _string_6
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+24]
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_clear_fn:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 145
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_num_args:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 150
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_15
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_16
label_15:
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+0]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_16:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_reg_fn:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 156
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _new_fn_reg_info
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
	push rax
	mov rax, qword [rbp-8]
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
_env_add_fn:
	push rcx
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 164
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 165
	push rax
	mov rax, _string_7
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+32]
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
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_17
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp+32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_fn_info
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	jmp label_18
label_17:
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
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
	add rax, 32
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+32]
	push rax
	mov rax, qword [rbp-8]
	add rax, 24
	pop rcx
	mov [rax], rcx
label_18:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_env_add_fn_arg:
	push rcx
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 181
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+32]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_arg_var
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
_env_register_scope:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 189
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	add rax, 40
	pop rcx
	mov [rax], rcx
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_deregister_scope:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 195
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 196
	push rax
	mov rax, _string_8
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+40]
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
	mov rax, [rax+40]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+8]
	add rax, 40
	pop rcx
	mov [rax], rcx
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_get_return_type:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 202
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
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
	je label_19
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_20
label_19:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_20:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_align:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 16
	push rax
	mov rax, 16
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cqo
	div rcx
	pop rcx
	mul rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_21
	mov rax, qword [rbp+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_22
label_21:
	mov rax, 16
	push rax
	mov rax, 1
	push rax
	mov rax, 16
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cqo
	div rcx
	pop rcx
	add rax, rcx
	pop rcx
	mul rcx
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_22:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_get_local_size:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 214
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_24
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+24]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_24:
	cmp rax, 0
	je label_23
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+24]
	mov rax, [rax+24]
	push rax
	pop rdi
	mov al, 0
	call _env_align
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_25
label_23:
	mov rax, _string_1
	push rax
	mov rax, 219
	push rax
	mov rax, _string_4
	push rax
	mov rax, 0
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
label_25:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_get_args_size:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 224
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
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
	je label_26
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _env_align
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_27
label_26:
	mov rax, _string_1
	push rax
	mov rax, 226
	push rax
	mov rax, _string_4
	push rax
	mov rax, 0
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
label_27:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_register_struct:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 230
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+56]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp+24]
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
_env_get_field:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 236
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 237
	push rax
	mov rax, _string_7
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, _string_1
	push rax
	mov rax, 238
	push rax
	mov rax, _string_9
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+24]
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
label_28:
	mov rax, 7
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_30
	mov rax, 6
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_30:
	cmp rax, 0
	je label_29
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	mov [rbp+16], rax
	jmp label_28
label_29:
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_32
	mov rax, 5
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_32:
	cmp rax, 0
	je label_31
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_33
	mov rax, _string_11
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
label_33:
	mov rax, _string_12
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_31:
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_env_register_typedef:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 256
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+64]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp+24]
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
_env_get_type:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 262
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+56]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	cmp rax, 0
	je label_34
	mov rax, qword [rbp+8]
	mov rax, [rax+56]
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
	jmp label_35
label_34:
	mov rax, qword [rbp+8]
	mov rax, [rax+64]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	cmp rax, 0
	je label_36
	mov rax, qword [rbp+8]
	mov rax, [rax+64]
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
	jmp label_37
label_36:
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_37:
label_35:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
__env_promote:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 3
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_38
	mov rax, qword [rbp+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_39
label_38:
	mov rax, 3
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_40
	mov rax, qword [rbp+16]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_41
label_40:
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_43
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_43:
	cmp rax, 0
	je label_42
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_44
label_42:
	mov rax, 2
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_46
	mov rax, 2
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_46:
	cmp rax, 0
	je label_45
	mov rax, 2
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_47
label_45:
	mov rax, qword [rbp+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_47:
label_44:
label_41:
label_39:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
__env_ast_binop_type:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __env_promote
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
__env_ast_unop_type:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_dereference_type:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
label_48:
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_50
	mov rax, 6
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_51
	mov rax, 7
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_51:
label_50:
	cmp rax, 0
	je label_49
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	mov [rbp+16], rax
	jmp label_48
label_49:
	mov rax, 3
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_52
	mov rax, _string_13
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
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
label_52:
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_ast_type:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 299
	push rax
	mov rax, _string_14
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, _string_1
	push rax
	mov rax, 300
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	mov [rbp-16], rax
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_53
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_info
	mov [rbp-24], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_54
	mov rax, 0
	mov [rbp-8], rax
label_54:
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	mov [rbp-8], rax
	jmp label_55
label_53:
	mov rax, 2
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_56
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-8], rax
	jmp label_57
label_56:
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_58
	mov rax, 2
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-8], rax
	jmp label_59
label_58:
	mov rax, 4
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_60
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_return_type
	mov [rbp-8], rax
	jmp label_61
label_60:
	mov rax, 6
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_62
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	mov [rbp-8], rax
	jmp label_63
label_62:
	mov rax, 7
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_64
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-8], rax
	jmp label_65
label_64:
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_66
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_dereference_type
	mov [rbp-32], rax
label_67:
	mov rax, 0
	push rax
	mov rax, qword [rbp-32]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_69
	mov rax, 6
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_70
	mov rax, 7
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_70:
label_69:
	cmp rax, 0
	je label_68
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	mov [rbp-32], rax
	jmp label_67
label_68:
	mov rax, 5
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_71
	mov rax, _string_15
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+0]
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
label_71:
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_field
	mov rax, [rax+0]
	mov [rbp-8], rax
	jmp label_72
label_66:
	mov rax, 9
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_73
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_dereference_type
	mov [rbp-8], rax
	jmp label_74
label_73:
	mov rax, 13
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_75
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __env_ast_unop_type
	push rax
	pop rdi
	mov al, 0
	call _type_new_pointer
	mov [rbp-8], rax
	jmp label_76
label_75:
	mov rax, 14
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_77
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __env_ast_unop_type
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_dereference_type
	mov [rbp-8], rax
	jmp label_78
label_77:
	mov rax, 10
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_80
	mov rax, 11
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_80:
	cmp rax, 0
	je label_79
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __env_ast_unop_type
	mov [rbp-8], rax
	jmp label_81
label_79:
	mov rax, 18
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_85
	mov rax, 19
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_85:
	test rax, rax
	jnz label_84
	mov rax, 16
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_84:
	test rax, rax
	jnz label_83
	mov rax, 17
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_83:
	cmp rax, 0
	je label_82
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __env_ast_binop_type
	mov [rbp-8], rax
	jmp label_86
label_82:
	mov rax, 15
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_95
	mov rax, 26
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_95:
	test rax, rax
	jnz label_94
	mov rax, 27
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_94:
	test rax, rax
	jnz label_93
	mov rax, 24
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_93:
	test rax, rax
	jnz label_92
	mov rax, 25
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_92:
	test rax, rax
	jnz label_91
	mov rax, 20
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_91:
	test rax, rax
	jnz label_90
	mov rax, 21
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_90:
	test rax, rax
	jnz label_89
	mov rax, 22
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_89:
	test rax, rax
	jnz label_88
	mov rax, 23
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_88:
	cmp rax, 0
	je label_87
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-8], rax
	jmp label_96
label_87:
	mov rax, 29
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_97
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	mov [rbp-8], rax
	jmp label_98
label_97:
	mov rax, 0
	mov [rbp-8], rax
label_98:
label_96:
label_86:
label_81:
label_78:
label_76:
label_74:
label_72:
label_65:
label_63:
label_61:
label_59:
label_57:
label_55:
label_99:
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_101
	mov rax, 6
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_102
	mov rax, 7
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_102:
label_101:
	cmp rax, 0
	je label_100
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	mov [rbp-8], rax
	jmp label_99
label_100:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_get_label:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	add rax, 72
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_register_end:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+80]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _push
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_last_end:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+80]
	push rax
	pop rdi
	mov al, 0
	call _pop
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+80]
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _push
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_deregister_end:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+80]
	push rax
	pop rdi
	mov al, 0
	call _pop
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_env_register_switch:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	add rax, 96
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
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
	mov rax, qword [rbp+8]
	mov rax, [rax+88]
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_env_add_enum_value:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 413
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_env
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_const_var
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
_type_get_size:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 420
	push rax
	mov rax, _string_16
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, 0
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	cmp rax, 1
	je switch_0_case_0
	cmp rax, 0
	je switch_0_case_1
	cmp rax, 3
	je switch_0_case_2
	cmp rax, 2
	je switch_0_case_3
	cmp rax, 6
	je switch_0_case_4
	cmp rax, 7
	je switch_0_case_5
	cmp rax, 5
	je switch_0_case_6
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
switch_0_case_4:
switch_0_case_5:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
switch_0_case_6:
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
switch_0_default:
	mov rax, _string_17
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
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
label_103:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_8: db 69, 45, 62, 115, 99, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_4: db 102, 97, 108, 115, 101, 0
	_string_14: db 110, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_9: db 102, 105, 101, 108, 100, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_2: db 105, 115, 95, 101, 110, 118, 40, 69, 41, 0
	_string_6: db 102, 45, 62, 108, 111, 99, 97, 108, 115, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_13: db 65, 116, 116, 101, 109, 112, 116, 101, 100, 32, 116, 111, 32, 100, 101, 114, 101, 102, 101, 114, 101, 110, 99, 101, 32, 110, 111, 110, 45, 112, 111, 105, 110, 116, 101, 114, 32, 116, 121, 112, 101, 32, 37, 105, 32, 40, 101, 110, 118, 95, 97, 115, 116, 95, 116, 121, 112, 101, 41, 10, 0
	_string_16: db 116, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_5: db 70, 117, 110, 99, 116, 105, 111, 110, 32, 37, 115, 32, 110, 111, 116, 32, 102, 111, 117, 110, 100, 10, 0
	_string_10: db 65, 116, 116, 101, 109, 112, 116, 101, 100, 32, 116, 111, 32, 103, 101, 116, 32, 102, 105, 101, 108, 100, 32, 102, 114, 111, 109, 32, 110, 111, 110, 45, 115, 116, 114, 117, 99, 116, 32, 40, 101, 110, 118, 95, 103, 101, 116, 95, 102, 105, 101, 108, 100, 41, 32, 0
	_string_12: db 10, 0
	_string_1: db 112, 97, 114, 115, 101, 114, 47, 101, 110, 118, 46, 99, 0
	_string_11: db 37, 105, 0
	_string_3: db 86, 97, 114, 105, 97, 98, 108, 101, 32, 39, 37, 115, 39, 32, 110, 111, 116, 32, 102, 111, 117, 110, 100, 10, 0
	_string_7: db 115, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_17: db 87, 104, 97, 116, 32, 105, 115, 32, 116, 121, 112, 101, 32, 37, 105, 63, 10, 0
	_string_15: db 65, 116, 116, 101, 109, 112, 116, 101, 100, 32, 116, 111, 32, 97, 114, 114, 111, 119, 32, 110, 111, 110, 45, 115, 116, 114, 117, 99, 116, 44, 32, 101, 110, 118, 32, 97, 115, 116, 32, 116, 121, 112, 101, 44, 32, 37, 105, 10, 0
global _env_get_label
extern _new_node_typedef
extern _new_node_struct
extern _sequence_empty
extern _fprintf
global _is_env
global _new_const_var
global _env_deregister_end
extern _new_node_char
extern _hash_insert
extern _strdup
global __env_promote
global _env_set_fn
extern _new_node_sequence
extern _new_node_string
extern _type_add_field
extern _hash_get
extern _my_assert
global _env_get_return_type
global _env_get_local_size
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
extern _env_do_over_switches
extern _env_do_over_strings
extern _strncmp
global _env_add_fn
extern _sequence_deq
extern _scope_add_local
extern _type_get_field
extern _queue_test
extern _fclose
extern _getline
extern _free
global _new_arg_var
global _env_register_end
extern _type_new_pointer
global _env_get_string
extern _new_node_call
extern _type_new_fn
extern _strndup
global _env_align
global _env_reg_fn
extern _new_node_statement
extern _new_node_cast
extern _token_delete
extern _hash_new
global _max
extern _env_do_over_fns
global _env_get_args_size
extern _new_node_switch
extern _new_node_binop
global _env_deregister_scope
global _env_get_info
extern _ast_construct_scope
extern _enum_add_val
extern _new_node_for
extern _pop
global _env_clear_fn
global _env_new
extern _queue_length
extern _stack_empty
global _new_local_var
global _env_register_scope
extern _new_node_sizeof
global _env_get_type
extern _new_node_fn_arg
extern _new_node_break
extern _new_node_ternary
extern _new_node_arrow
extern _new_node_int
extern _scope_new
extern _peek
extern _stack_new
global _env_dereference_type
global _new_fn_reg_info
global _type_get_size
global _env_register_struct
global _env_add_fn_arg
extern _print_node
extern _type_print
extern _types_init
extern _queue_free
extern _push
extern _hash_in
extern _env_do_over_vars
extern _new_node_enum
extern _type_pointer_inner
global _env_ast_type
global _env_get_field
global _env_add_global
extern _new_node_while
extern _is_scope
extern _queue_empty
global _new_fn_info
global _env_last_end
global _env_num_args
extern _new_node_unop
global __env_ast_unop_type
extern _type_new_base
extern _hash_do_over
extern _new_node_function
extern _new_node_case
extern _node_call_enq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
global __env_ast_binop_type
global _env_add_enum_value
extern _new_node_if
extern _printf
global _new_global_var
global _env_register_switch
extern _scope_find_local
extern _type_new_undet
extern _type_new_undet_struct
global _env_register_typedef
extern _new_node_declaration
extern _str_token_type
extern _node_call_empty
extern _new_node_var
extern _type_new_struct
extern _strcmp
extern _sequence_enq
extern _node_call_deq
extern _enq
extern _token_new
extern _exit
