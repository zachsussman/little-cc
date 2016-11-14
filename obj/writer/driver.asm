default rel
section .text

_emit:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_1
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_ast_int_write:
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
	mov rax, 16
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 17
	push rax
	mov rax, _string_4
	push rax
	mov rax, 2
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_char_write:
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
	mov rax, 24
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 25
	push rax
	mov rax, _string_6
	push rax
	mov rax, 3
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_var_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 32
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 33
	push rax
	mov rax, _string_7
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_info
	mov [rbp-16], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	mov [rbp-24], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	mov [rbp-40], rax
	mov rax, _string_8
	push rax
	mov rax, _string_2
	push rax
	mov rax, 42
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_2
	mov rax, 1
	push rax
	mov rax, _string_9
	push rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_2:
	test rax, rax
	jz label_1
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_1:
	mov rax, 1
	push rax
	mov rax, qword [rbp-40]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_3
	mov rax, _string_11
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_4
label_3:
	mov rax, _string_12
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
label_4:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_5
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_13
	push rax
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_6
label_5:
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_7
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_14
	push rax
	mov rax, qword [rbp-32]
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_8
label_7:
	mov rax, 2
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_9
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_15
	push rax
	mov rax, qword [rbp-32]
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_10
label_9:
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_11
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_11:
label_10:
label_8:
label_6:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_string_write:
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
	mov rax, _string_2
	push rax
	mov rax, 62
	push rax
	mov rax, _string_16
	push rax
	mov rax, 5
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_string
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_17
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_call_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 70
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 71
	push rax
	mov rax, _string_18
	push rax
	mov rax, 4
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
label_12:
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _node_call_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_13
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _node_call_deq
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_19
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_12
label_13:
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	sub rax, rcx
	mov [rbp-24], rax
label_14:
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setge al
	movzx rax, al
	cmp rax, 0
	je label_15
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_20
	push rax
	mov rax, qword [rbp-24]
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	lea rax, [rbp-24]
	mov rcx, [rax]
	sub qword [rax], 1
	mov rax, rcx
	jmp label_14
label_15:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_21
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_22
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_sizeof_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 90
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 91
	push rax
	mov rax, _string_23
	push rax
	mov rax, 7
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	mov [rbp-16], rax
label_16:
	mov rax, 7
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_18
	mov rax, 6
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_18:
	cmp rax, 0
	je label_17
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_16
label_17:
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_24
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_arrow_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 102
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 103
	push rax
	mov rax, _string_25
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	mov [rbp-16], rax
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_19
	mov rax, _string_26
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_19:
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	mov [rbp-24], rax
label_20:
	mov rax, 7
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_22
	mov rax, 6
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_22:
	cmp rax, 0
	je label_21
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_20
label_21:
	mov rax, 5
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_23
	mov rax, _string_27
	push rax
	mov rax, qword [rbp-24]
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
label_23:
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_field
	mov [rbp-32], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-32]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_24
	mov rax, _string_28
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	mov rax, [rax+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
label_24:
	mov rax, qword [rbp-32]
	mov rax, [rax+8]
	mov [rbp-40], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_29
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-40]
	pop rcx
	mul rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_array_sub_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 131
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 132
	push rax
	mov rax, _string_30
	push rax
	mov rax, 9
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	mov [rbp-16], rax
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_25
	mov rax, _string_26
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_25:
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	mov [rbp-24], rax
label_26:
	mov rax, 7
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_28
	mov rax, 6
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_28:
	cmp rax, 0
	je label_27
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_26
label_27:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_31
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_19
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_32
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_33
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, 1
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_29
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_34
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_35
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_36
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	jmp label_30
label_29:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_37
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
label_30:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_cast_write:
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
	mov rax, 160
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 161
	push rax
	mov rax, _string_38
	push rax
	mov rax, 6
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_increment_write:
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
	mov rax, 168
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 169
	push rax
	mov rax, _string_39
	push rax
	mov rax, 10
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_lvalue_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_40
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_41
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_36
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_decrement_write:
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
	mov rax, 180
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 181
	push rax
	mov rax, _string_42
	push rax
	mov rax, 11
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_lvalue_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_40
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_43
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_36
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_negative_write:
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
	mov rax, 192
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 193
	push rax
	mov rax, _string_44
	push rax
	mov rax, 12
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_45
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_address_write:
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
	mov rax, 202
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 203
	push rax
	mov rax, _string_46
	push rax
	mov rax, 13
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_lvalue_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_dereference_write:
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
	mov rax, 211
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 212
	push rax
	mov rax, _string_47
	push rax
	mov rax, 14
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	mov [rbp-16], rax
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_31
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_34
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_35
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_36
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	jmp label_32
label_31:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_37
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
label_32:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_logical_not_write:
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
	mov rax, 229
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 230
	push rax
	mov rax, _string_48
	push rax
	mov rax, 15
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_49
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_50
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_51
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_binop_write:
	push rcx
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 240
	push rax
	mov rax, _string_3
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_19
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_32
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_add_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 252
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 253
	push rax
	mov rax, _string_52
	push rax
	mov rax, 18
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_33
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_sub_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 259
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 260
	push rax
	mov rax, _string_53
	push rax
	mov rax, 19
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_54
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_mul_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 266
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 267
	push rax
	mov rax, _string_55
	push rax
	mov rax, 16
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_56
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_div_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 273
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 274
	push rax
	mov rax, _string_57
	push rax
	mov rax, 17
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_58
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_lt_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 280
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 281
	push rax
	mov rax, _string_59
	push rax
	mov rax, 20
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_60
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_lte_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 287
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 288
	push rax
	mov rax, _string_61
	push rax
	mov rax, 21
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_62
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_gt_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 294
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 295
	push rax
	mov rax, _string_63
	push rax
	mov rax, 22
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_64
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_gte_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 301
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 302
	push rax
	mov rax, _string_65
	push rax
	mov rax, 23
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_66
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_eq_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 308
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 309
	push rax
	mov rax, _string_67
	push rax
	mov rax, 24
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_68
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_neq_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 315
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 316
	push rax
	mov rax, _string_69
	push rax
	mov rax, 25
	push rax
	mov rax, qword [rbp+16]
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
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, _string_70
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_binop_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_lvalue_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 64
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 322
	push rax
	mov rax, _string_3
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
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_33
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_info
	mov [rbp-16], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_34
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_71
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_35
label_34:
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_36
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_72
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_37
label_36:
	mov rax, 2
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_38
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_73
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_38:
label_37:
label_35:
	jmp label_39
label_33:
	mov rax, 14
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_40
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	jmp label_41
label_40:
	mov rax, 8
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_42
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	mov [rbp-16], rax
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_43
	mov rax, _string_74
	push rax
	mov rax, qword [rbp-16]
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
label_43:
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_field
	mov rax, [rax+8]
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_75
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	mul rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_44
label_42:
	mov rax, 9
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_45
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_ast_type
	mov [rbp-16], rax
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_46
	mov rax, _string_26
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_46:
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	mov [rbp-24], rax
label_47:
	mov rax, 7
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_49
	mov rax, 6
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_49:
	cmp rax, 0
	je label_48
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_type
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_47
label_48:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_31
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _type_get_size
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_19
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_32
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_33
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
label_45:
label_44:
label_41:
label_39:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_logical_and_write:
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
	mov rax, 370
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 371
	push rax
	mov rax, _string_76
	push rax
	mov rax, 26
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_49
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_77
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_logical_or_write:
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
	mov rax, 384
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 385
	push rax
	mov rax, _string_79
	push rax
	mov rax, 27
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_49
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_80
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_ternary_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 398
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 399
	push rax
	mov rax, _string_81
	push rax
	mov rax, 28
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_49
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_77
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_82
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_assign_write:
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
	mov rax, 416
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 417
	push rax
	mov rax, _string_83
	push rax
	mov rax, 29
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_19
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_lvalue_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_32
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
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
	call _type_get_size
	mov [rbp-16], rax
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_50
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_84
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	jmp label_51
label_50:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_85
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
label_51:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_statement_write:
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
	mov rax, 433
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 434
	push rax
	mov rax, _string_86
	push rax
	mov rax, 31
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_if_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 441
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 442
	push rax
	mov rax, _string_87
	push rax
	mov rax, 32
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_88
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_89
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_52
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_53
label_52:
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_82
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_53:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_while_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 464
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 465
	push rax
	mov rax, _string_90
	push rax
	mov rax, 33
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-16], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_end
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_88
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_89
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_82
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_deregister_end
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_for_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 485
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 486
	push rax
	mov rax, _string_91
	push rax
	mov rax, 35
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-16], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_end
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-24], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_scope
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_88
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_89
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+24]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_82
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_deregister_end
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_deregister_scope
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_return_write:
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
	mov rax, 512
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 513
	push rax
	mov rax, _string_92
	push rax
	mov rax, 34
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_93
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_94
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_95
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_args_size
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_96
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_break_write:
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
	mov rax, 526
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 527
	push rax
	mov rax, _string_97
	push rax
	mov rax, 36
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_last_end
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_82
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_declaration_write:
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
	mov rax, 534
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 535
	push rax
	mov rax, _string_98
	push rax
	mov rax, 30
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_54
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
label_54:
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_get_info
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_99
	push rax
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_sequence_write:
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
	mov rax, 546
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 547
	push rax
	mov rax, _string_100
	push rax
	mov rax, 38
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_scope
label_55:
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _sequence_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_56
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _sequence_deq
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	jmp label_55
label_56:
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_deregister_scope
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_switch_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 561
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 562
	push rax
	mov rax, _string_101
	push rax
	mov rax, 37
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_switch
	mov [rbp-16], rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_label
	mov [rbp-24], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_end
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_scope
	mov rax, 0
	mov [rbp-32], rax
label_57:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-32]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_58
	mov rax, 0
	push rax
	mov rax, qword [rbp-32]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_59
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_102
	push rax
	mov rax, qword [rbp-32]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_103
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_59:
	lea rax, [rbp-32]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_57
label_58:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_104
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, 0
	mov [rbp-32], rax
label_60:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-32]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_61
	mov rax, qword [rbp-32]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	cmp rax, 0
	je label_62
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_105
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
label_62:
	lea rax, [rbp-32]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_60
label_61:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_106
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+24]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_78
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_deregister_end
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_deregister_scope
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_function_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 608
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 609
	push rax
	mov rax, _string_107
	push rax
	mov rax, 39
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+32]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_63
	mov rax, qword [rbp+24]
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
	call _env_reg_fn
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
label_63:
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _ast_construct_scope
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+40]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_add_fn
	mov rax, 0
	mov [rbp-16], rax
label_64:
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_65
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+24]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+24]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+8]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_add_fn_arg
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_64
label_65:
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_set_fn
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_108
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, 2
	push rax
	mov rax, 2
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	cqo
	div rcx
	pop rcx
	mul rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_66
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_109
	push rax
	mov rax, 8
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_66:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	sub rax, rcx
	mov [rbp-16], rax
label_67:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setge al
	movzx rax, al
	cmp rax, 0
	je label_68
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_110
	push rax
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	lea rax, [rbp-16]
	mov rcx, [rax]
	sub qword [rax], 1
	mov rax, rcx
	jmp label_67
label_68:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_111
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_112
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+40]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_scope
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_local_size
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_109
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_113
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+32]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_93
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_94
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_95
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_get_args_size
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_96
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _env_clear_fn
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_global_write:
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
	mov rax, 659
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 660
	push rax
	mov rax, _string_114
	push rax
	mov rax, 40
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_add_global
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_struct_write:
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
	mov rax, 667
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 668
	push rax
	mov rax, _string_115
	push rax
	mov rax, 41
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_struct
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_typedef_write:
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
	mov rax, 675
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 676
	push rax
	mov rax, _string_116
	push rax
	mov rax, 42
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
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
	call _env_register_typedef
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_enum_write:
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
	mov rax, 683
	push rax
	mov rax, _string_3
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
	mov rax, _string_2
	push rax
	mov rax, 684
	push rax
	mov rax, _string_117
	push rax
	mov rax, 43
	push rax
	mov rax, qword [rbp+16]
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
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_register_typedef
	mov rax, 0
	mov [rbp-16], rax
label_69:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_70
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _env_add_enum_value
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_69
label_70:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_ast_write:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_2
	push rax
	mov rax, 698
	push rax
	mov rax, _string_3
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
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	cmp rax, 2
	je switch_0_case_0
	cmp rax, 3
	je switch_0_case_1
	cmp rax, 1
	je switch_0_case_2
	cmp rax, 5
	je switch_0_case_3
	cmp rax, 4
	je switch_0_case_4
	cmp rax, 7
	je switch_0_case_5
	cmp rax, 6
	je switch_0_case_6
	cmp rax, 8
	je switch_0_case_7
	cmp rax, 9
	je switch_0_case_8
	cmp rax, 10
	je switch_0_case_9
	cmp rax, 11
	je switch_0_case_10
	cmp rax, 12
	je switch_0_case_11
	cmp rax, 13
	je switch_0_case_12
	cmp rax, 14
	je switch_0_case_13
	cmp rax, 15
	je switch_0_case_14
	cmp rax, 18
	je switch_0_case_15
	cmp rax, 19
	je switch_0_case_16
	cmp rax, 16
	je switch_0_case_17
	cmp rax, 17
	je switch_0_case_18
	cmp rax, 20
	je switch_0_case_19
	cmp rax, 21
	je switch_0_case_20
	cmp rax, 22
	je switch_0_case_21
	cmp rax, 23
	je switch_0_case_22
	cmp rax, 24
	je switch_0_case_23
	cmp rax, 25
	je switch_0_case_24
	cmp rax, 26
	je switch_0_case_25
	cmp rax, 27
	je switch_0_case_26
	cmp rax, 28
	je switch_0_case_27
	cmp rax, 29
	je switch_0_case_28
	cmp rax, 30
	je switch_0_case_29
	cmp rax, 31
	je switch_0_case_30
	cmp rax, 32
	je switch_0_case_31
	cmp rax, 33
	je switch_0_case_32
	cmp rax, 34
	je switch_0_case_33
	cmp rax, 35
	je switch_0_case_34
	cmp rax, 36
	je switch_0_case_35
	cmp rax, 37
	je switch_0_case_36
	cmp rax, 38
	je switch_0_case_37
	cmp rax, 39
	je switch_0_case_38
	cmp rax, 40
	je switch_0_case_39
	cmp rax, 41
	je switch_0_case_40
	cmp rax, 42
	je switch_0_case_41
	cmp rax, 43
	je switch_0_case_42
	jmp switch_0_default
switch_0_case_0:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_int_write
	jmp label_71
switch_0_case_1:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_char_write
	jmp label_71
switch_0_case_2:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_var_write
	jmp label_71
switch_0_case_3:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_string_write
	jmp label_71
switch_0_case_4:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_call_write
	jmp label_71
switch_0_case_5:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_sizeof_write
	jmp label_71
switch_0_case_6:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_cast_write
	jmp label_71
switch_0_case_7:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_arrow_write
	jmp label_71
switch_0_case_8:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_array_sub_write
	jmp label_71
switch_0_case_9:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_increment_write
	jmp label_71
switch_0_case_10:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_decrement_write
	jmp label_71
switch_0_case_11:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_negative_write
	jmp label_71
switch_0_case_12:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_address_write
	jmp label_71
switch_0_case_13:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_dereference_write
	jmp label_71
switch_0_case_14:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_logical_not_write
	jmp label_71
switch_0_case_15:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_add_write
	jmp label_71
switch_0_case_16:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_sub_write
	jmp label_71
switch_0_case_17:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_mul_write
	jmp label_71
switch_0_case_18:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_div_write
	jmp label_71
switch_0_case_19:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_lt_write
	jmp label_71
switch_0_case_20:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_lte_write
	jmp label_71
switch_0_case_21:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_gt_write
	jmp label_71
switch_0_case_22:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_gte_write
	jmp label_71
switch_0_case_23:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_eq_write
	jmp label_71
switch_0_case_24:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_neq_write
	jmp label_71
switch_0_case_25:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_logical_and_write
	jmp label_71
switch_0_case_26:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_logical_or_write
	jmp label_71
switch_0_case_27:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_ternary_write
	jmp label_71
switch_0_case_28:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_assign_write
	jmp label_71
switch_0_case_29:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_declaration_write
	jmp label_71
switch_0_case_30:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_statement_write
	jmp label_71
switch_0_case_31:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_if_write
	jmp label_71
switch_0_case_32:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_while_write
	jmp label_71
switch_0_case_33:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_return_write
	jmp label_71
switch_0_case_34:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_for_write
	jmp label_71
switch_0_case_35:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_break_write
	jmp label_71
switch_0_case_36:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_switch_write
	jmp label_71
switch_0_case_37:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_sequence_write
	jmp label_71
switch_0_case_38:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_function_write
	jmp label_71
switch_0_case_39:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_global_write
	jmp label_71
switch_0_case_40:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_struct_write
	jmp label_71
switch_0_case_41:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_typedef_write
	jmp label_71
switch_0_case_42:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_enum_write
	jmp label_71
switch_0_default:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_118
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_71
label_71:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_write_header:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 6
	push rax
	mov rax, 8
	pop rcx
	mul rcx
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	mov rax, g1
	pop rcx
	mov [rax], rcx
	mov rax, _string_119
	push rax
	mov rax, 0
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, _string_120
	push rax
	mov rax, 1
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, _string_121
	push rax
	mov rax, 2
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, _string_122
	push rax
	mov rax, 3
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, _string_123
	push rax
	mov rax, 4
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, _string_124
	push rax
	mov rax, 5
	imul rax, 8
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_125
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_126
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_10
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_write_var:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 3
	push rax
	mov rax, qword [rbp+24]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_72
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
label_72:
	mov rax, qword [rbp+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_127
	push rax
	mov rax, qword [rbp+24]
	mov rax, [rax+16]
	push rax
	mov rax, _string_128
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_write_string:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_129
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_73:
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_74
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_130
	push rax
	mov rax, qword [rbp+16]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	lea rax, [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_73
label_74:
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_131
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_write_fn_info:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 1
	neg rax
	push rax
	mov rax, qword [rbp+24]
	mov rax, [rax+32]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_75
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_132
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	jmp label_76
label_75:
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_133
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
label_76:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_write_switch:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_134
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, 0
	mov [rbp-8], rax
label_77:
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_78
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_135
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_77
label_78:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_write_env_vars:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	mov [rbp-8], rax
	mov rax, _string_2
	push rax
	mov rax, 881
	push rax
	mov rax, _string_136
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
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
	mov [rbp-16], rax
label_79:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_80
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-24], rax
label_81:
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_82
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _write_var
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_81
label_82:
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_79
label_80:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_write_env_strings:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+32]
	mov [rbp-8], rax
	mov rax, _string_2
	push rax
	mov rax, 894
	push rax
	mov rax, _string_136
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
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
	mov [rbp-16], rax
label_83:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_84
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-24], rax
label_85:
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_86
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _write_string
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_85
label_86:
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_83
label_84:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_write_env_fns:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+48]
	mov [rbp-8], rax
	mov rax, _string_2
	push rax
	mov rax, 907
	push rax
	mov rax, _string_136
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
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
	mov [rbp-16], rax
label_87:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_88
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-24], rax
label_89:
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_90
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _write_fn_info
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_89
label_90:
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_87
label_88:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_write_footer:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_137
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_138
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fprintf
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_139
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _emit
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _write_env_vars
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _write_env_strings
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _write_env_fns
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	g1: dq 0
	_string_122: db 114, 99, 120, 0
	_string_89: db 9, 106, 101, 32, 108, 97, 98, 101, 108, 95, 37, 105, 10, 0
	_string_73: db 9, 108, 101, 97, 32, 114, 97, 120, 44, 32, 91, 114, 98, 112, 45, 37, 105, 93, 10, 0
	_string_48: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 76, 79, 71, 73, 67, 65, 76, 95, 78, 79, 84, 0
	_string_28: db 70, 105, 101, 108, 100, 32, 37, 115, 32, 110, 111, 116, 32, 102, 111, 117, 110, 100, 32, 105, 110, 32, 115, 116, 114, 117, 99, 116, 32, 37, 115, 10, 0
	_string_24: db 9, 109, 111, 118, 32, 114, 97, 120, 44, 32, 37, 100, 10, 0
	_string_21: db 109, 111, 118, 32, 97, 108, 44, 32, 48, 0
	_string_17: db 9, 109, 111, 118, 32, 114, 97, 120, 44, 32, 95, 115, 116, 114, 105, 110, 103, 95, 37, 105, 10, 0
	_string_101: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 87, 73, 84, 67, 72, 0
	_string_74: db 65, 116, 116, 101, 109, 112, 116, 101, 100, 32, 116, 111, 32, 100, 101, 114, 101, 102, 101, 114, 101, 110, 99, 101, 32, 110, 111, 110, 45, 112, 111, 105, 110, 116, 101, 114, 32, 116, 121, 112, 101, 32, 37, 105, 0
	_string_69: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 78, 69, 81, 0
	_string_65: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 71, 84, 69, 0
	_string_41: db 97, 100, 100, 32, 113, 119, 111, 114, 100, 32, 91, 114, 97, 120, 93, 44, 32, 49, 0
	_string_36: db 109, 111, 118, 32, 114, 97, 120, 44, 32, 114, 99, 120, 0
	_string_15: db 9, 37, 115, 32, 91, 114, 98, 112, 45, 37, 105, 93, 10, 0
	_string_128: db 100, 113, 0
	_string_96: db 114, 101, 116, 0
	_string_79: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 76, 79, 71, 73, 67, 65, 76, 95, 79, 82, 0
	_string_121: db 114, 100, 120, 0
	_string_120: db 114, 115, 105, 0
	_string_115: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 84, 82, 85, 67, 84, 95, 68, 69, 67, 76, 65, 82, 65, 84, 73, 79, 78, 0
	_string_59: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 76, 84, 0
	_string_47: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 68, 69, 82, 69, 70, 69, 82, 69, 78, 67, 69, 0
	_string_3: db 110, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_62: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 114, 99, 120, 10, 9, 115, 101, 116, 108, 101, 32, 97, 108, 10, 9, 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 97, 108, 0
	_string_29: db 9, 109, 111, 118, 32, 114, 97, 120, 44, 32, 91, 114, 97, 120, 43, 37, 105, 93, 10, 0
	_string_112: db 109, 111, 118, 32, 114, 98, 112, 44, 32, 114, 115, 112, 0
	_string_88: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 48, 0
	_string_18: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 70, 78, 95, 67, 65, 76, 76, 0
	_string_113: db 97, 110, 100, 32, 114, 115, 112, 44, 32, 45, 49, 54, 0
	_string_51: db 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 99, 108, 0
	_string_35: db 109, 111, 118, 32, 99, 108, 44, 32, 91, 114, 97, 120, 93, 0
	_string_117: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 69, 78, 85, 77, 0
	_string_106: db 115, 119, 105, 116, 99, 104, 95, 37, 105, 95, 100, 101, 102, 97, 117, 108, 116, 58, 10, 0
	_string_57: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 68, 73, 86, 73, 83, 73, 79, 78, 0
	_string_44: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 78, 69, 71, 65, 84, 73, 86, 69, 0
	_string_16: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 84, 82, 73, 78, 71, 0
	_string_134: db 115, 119, 105, 116, 99, 104, 95, 116, 97, 98, 108, 101, 95, 37, 105, 58, 10, 0
	_string_67: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 69, 81, 0
	_string_110: db 9, 112, 117, 115, 104, 32, 37, 115, 10, 0
	_string_87: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 73, 70, 0
	_string_83: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 65, 83, 83, 73, 71, 78, 0
	_string_81: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 84, 69, 82, 78, 65, 82, 89, 0
	_string_137: db 0
	_string_98: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 76, 79, 67, 65, 76, 95, 68, 69, 67, 76, 65, 82, 65, 84, 73, 79, 78, 0
	_string_85: db 109, 111, 118, 32, 91, 114, 97, 120, 93, 44, 32, 114, 99, 120, 0
	_string_52: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 65, 68, 68, 73, 84, 73, 79, 78, 0
	_string_49: db 116, 101, 115, 116, 32, 114, 97, 120, 44, 32, 114, 97, 120, 0
	_string_37: db 109, 111, 118, 32, 114, 97, 120, 44, 32, 91, 114, 97, 120, 93, 0
	_string_138: db 115, 101, 99, 116, 105, 111, 110, 32, 46, 100, 97, 116, 97, 10, 0
	_string_118: db 59, 32, 117, 110, 107, 110, 111, 119, 110, 32, 105, 110, 115, 116, 114, 117, 99, 116, 105, 111, 110, 32, 37, 105, 10, 0
	_string_75: db 9, 97, 100, 100, 32, 114, 97, 120, 44, 32, 37, 105, 10, 0
	_string_66: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 114, 99, 120, 10, 9, 115, 101, 116, 103, 101, 32, 97, 108, 10, 9, 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 97, 108, 0
	_string_131: db 48, 10, 0
	_string_114: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 71, 76, 79, 66, 65, 76, 95, 68, 69, 67, 76, 65, 82, 65, 84, 73, 79, 78, 0
	_string_111: db 112, 117, 115, 104, 32, 114, 98, 112, 0
	_string_84: db 109, 111, 118, 32, 91, 114, 97, 120, 93, 44, 32, 99, 108, 0
	_string_46: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 65, 68, 68, 82, 69, 83, 83, 0
	_string_10: db 10, 0
	_string_76: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 76, 79, 71, 73, 67, 65, 76, 95, 65, 78, 68, 0
	_string_60: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 114, 99, 120, 10, 9, 115, 101, 116, 108, 32, 97, 108, 10, 9, 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 97, 108, 0
	_string_31: db 9, 105, 109, 117, 108, 32, 114, 97, 120, 44, 32, 37, 105, 10, 0
	_string_2: db 119, 114, 105, 116, 101, 114, 47, 100, 114, 105, 118, 101, 114, 46, 99, 0
	_string_126: db 115, 101, 99, 116, 105, 111, 110, 32, 46, 116, 101, 120, 116, 10, 0
	_string_5: db 9, 109, 111, 118, 32, 114, 97, 120, 44, 32, 37, 105, 10, 0
	_string_4: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 73, 78, 84, 69, 71, 69, 82, 0
	_string_136: db 72, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_108: db 95, 37, 115, 58, 10, 0
	_string_94: db 112, 111, 112, 32, 114, 98, 112, 0
	_string_86: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 84, 65, 84, 69, 77, 69, 78, 84, 0
	_string_61: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 76, 84, 69, 0
	_string_39: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 73, 78, 67, 82, 69, 77, 69, 78, 84, 0
	_string_11: db 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 98, 121, 116, 101, 0
	_string_123: db 114, 56, 0
	_string_124: db 114, 57, 0
	_string_119: db 114, 100, 105, 0
	_string_72: db 9, 108, 101, 97, 32, 114, 97, 120, 44, 32, 91, 114, 98, 112, 43, 37, 105, 93, 10, 0
	_string_63: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 71, 84, 0
	_string_50: db 115, 101, 116, 122, 32, 99, 108, 0
	_string_38: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 67, 65, 83, 84, 0
	_string_27: db 65, 116, 116, 101, 109, 112, 116, 101, 100, 32, 116, 111, 32, 97, 114, 114, 111, 119, 32, 110, 111, 110, 45, 115, 116, 114, 117, 99, 116, 45, 112, 111, 105, 110, 116, 101, 114, 32, 37, 105, 10, 0
	_string_19: db 112, 117, 115, 104, 32, 114, 97, 120, 0
	_string_68: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 114, 99, 120, 10, 9, 115, 101, 116, 101, 32, 97, 108, 10, 9, 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 97, 108, 0
	_string_20: db 9, 112, 111, 112, 32, 37, 115, 10, 0
	_string_14: db 9, 37, 115, 32, 91, 114, 98, 112, 43, 37, 105, 93, 10, 0
	_string_12: db 109, 111, 118, 32, 114, 97, 120, 44, 32, 113, 119, 111, 114, 100, 0
	_string_132: db 101, 120, 116, 101, 114, 110, 32, 95, 37, 115, 10, 0
	_string_104: db 9, 106, 109, 112, 32, 115, 119, 105, 116, 99, 104, 95, 37, 105, 95, 100, 101, 102, 97, 117, 108, 116, 10, 0
	_string_100: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 69, 81, 85, 69, 78, 67, 69, 0
	_string_91: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 70, 79, 82, 0
	_string_129: db 9, 95, 115, 116, 114, 105, 110, 103, 95, 37, 105, 58, 32, 100, 98, 32, 0
	_string_109: db 9, 115, 117, 98, 32, 114, 115, 112, 44, 32, 37, 105, 10, 0
	_string_102: db 9, 99, 109, 112, 32, 114, 97, 120, 44, 32, 37, 105, 10, 0
	_string_77: db 9, 106, 122, 32, 108, 97, 98, 101, 108, 95, 37, 105, 10, 0
	_string_70: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 114, 99, 120, 10, 9, 115, 101, 116, 110, 101, 32, 97, 108, 10, 9, 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 97, 108, 0
	_string_53: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 85, 66, 84, 82, 65, 67, 84, 73, 79, 78, 0
	_string_99: db 9, 109, 111, 118, 32, 91, 114, 98, 112, 45, 37, 105, 93, 44, 32, 114, 97, 120, 10, 0
	_string_97: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 66, 82, 69, 65, 75, 0
	_string_78: db 108, 97, 98, 101, 108, 95, 37, 105, 58, 10, 0
	_string_71: db 9, 109, 111, 118, 32, 114, 97, 120, 44, 32, 103, 37, 105, 10, 0
	_string_25: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 65, 82, 82, 79, 87, 0
	_string_1: db 9, 37, 115, 10, 0
	_string_133: db 103, 108, 111, 98, 97, 108, 32, 95, 37, 115, 10, 0
	_string_55: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 77, 85, 76, 84, 73, 80, 76, 73, 67, 65, 84, 73, 79, 78, 0
	_string_9: db 115, 105, 122, 101, 32, 111, 102, 32, 118, 97, 114, 32, 37, 115, 32, 105, 115, 32, 37, 100, 0
	_string_7: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 86, 65, 82, 73, 65, 66, 76, 69, 0
	_string_135: db 9, 100, 113, 32, 115, 119, 105, 116, 99, 104, 95, 37, 105, 95, 99, 97, 115, 101, 95, 37, 105, 10, 0
	_string_116: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 84, 89, 80, 69, 68, 69, 70, 0
	_string_95: db 9, 97, 100, 100, 32, 114, 115, 112, 44, 32, 37, 105, 10, 0
	_string_93: db 109, 111, 118, 32, 114, 115, 112, 44, 32, 114, 98, 112, 0
	_string_56: db 109, 117, 108, 32, 114, 99, 120, 0
	_string_45: db 110, 101, 103, 32, 114, 97, 120, 0
	_string_43: db 115, 117, 98, 32, 113, 119, 111, 114, 100, 32, 91, 114, 97, 120, 93, 44, 32, 49, 0
	_string_139: db 100, 117, 109, 109, 121, 58, 32, 100, 119, 32, 49, 54, 0
	_string_92: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 82, 69, 84, 85, 82, 78, 0
	_string_80: db 9, 106, 110, 122, 32, 108, 97, 98, 101, 108, 95, 37, 105, 10, 0
	_string_64: db 99, 109, 112, 32, 114, 97, 120, 44, 32, 114, 99, 120, 10, 9, 115, 101, 116, 103, 32, 97, 108, 10, 9, 109, 111, 118, 122, 120, 32, 114, 97, 120, 44, 32, 97, 108, 0
	_string_58: db 99, 113, 111, 10, 9, 100, 105, 118, 32, 114, 99, 120, 0
	_string_54: db 115, 117, 98, 32, 114, 97, 120, 44, 32, 114, 99, 120, 0
	_string_30: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 65, 82, 82, 65, 89, 95, 83, 85, 66, 0
	_string_22: db 9, 99, 97, 108, 108, 32, 95, 37, 115, 10, 0
	_string_13: db 9, 37, 115, 32, 91, 103, 37, 105, 93, 10, 0
	_string_6: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 67, 72, 65, 82, 0
	_string_105: db 115, 119, 105, 116, 99, 104, 95, 37, 105, 95, 99, 97, 115, 101, 95, 37, 105, 58, 10, 0
	_string_103: db 9, 106, 101, 32, 115, 119, 105, 116, 99, 104, 95, 37, 105, 95, 99, 97, 115, 101, 95, 37, 105, 10, 0
	_string_125: db 100, 101, 102, 97, 117, 108, 116, 32, 114, 101, 108, 10, 0
	_string_32: db 112, 111, 112, 32, 114, 99, 120, 0
	_string_23: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 73, 90, 69, 79, 70, 0
	_string_8: db 37, 115, 58, 37, 100, 32, 9, 0
	_string_90: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 87, 72, 73, 76, 69, 0
	_string_82: db 9, 106, 109, 112, 32, 108, 97, 98, 101, 108, 95, 37, 105, 10, 0
	_string_42: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 68, 69, 67, 82, 69, 77, 69, 78, 84, 0
	_string_34: db 120, 111, 114, 32, 114, 99, 120, 44, 32, 114, 99, 120, 0
	_string_33: db 97, 100, 100, 32, 114, 97, 120, 44, 32, 114, 99, 120, 0
	_string_130: db 37, 105, 44, 32, 0
	_string_127: db 9, 103, 37, 105, 58, 32, 37, 115, 32, 48, 10, 0
	_string_107: db 110, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 70, 85, 78, 67, 84, 73, 79, 78, 0
	_string_40: db 109, 111, 118, 32, 114, 99, 120, 44, 32, 91, 114, 97, 120, 93, 0
	_string_26: db 65, 116, 116, 101, 109, 112, 116, 101, 100, 32, 116, 111, 32, 100, 101, 114, 101, 102, 101, 114, 101, 110, 99, 101, 32, 110, 111, 110, 45, 112, 111, 105, 110, 116, 101, 114, 10, 0
extern _env_get_label
extern _new_node_typedef
extern _new_node_struct
extern _sequence_empty
extern _fprintf
global _ast_while_write
global _ast_lte_write
global _ast_increment_write
global _ast_int_write
extern _env_deregister_end
extern _new_node_char
extern _hash_insert
extern _strdup
extern _env_set_fn
extern _new_node_sequence
extern _new_node_string
extern _type_add_field
extern _hash_get
extern _my_assert
global _ast_typedef_write
extern _env_get_local_size
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
global _ast_sub_write
global _write_footer
extern _env_do_over_switches
extern _env_do_over_strings
extern _strncmp
global _write_switch
global _ast_if_write
global _ast_write
extern _env_add_fn
extern _sequence_deq
extern _scope_add_local
extern _type_get_field
extern _queue_test
extern _fclose
extern _getline
extern _free
global _write_var
global _ast_declaration_write
extern _env_register_end
extern _type_new_pointer
global _ast_break_write
global _ast_arrow_write
global _ast_var_write
extern _env_get_string
extern _new_node_call
extern _type_new_fn
extern _strndup
global _write_fn_info
global _ast_return_write
global _ast_lt_write
extern _env_reg_fn
extern _new_node_statement
extern _new_node_cast
extern _hash_new
extern _token_delete
global _ast_enum_write
global _ast_sequence_write
global _ast_cast_write
extern _env_do_over_fns
extern _env_get_args_size
extern _new_node_switch
extern _new_node_binop
global _ast_mul_write
global _write_header
extern _env_deregister_scope
extern _env_get_info
extern _pop
extern _ast_construct_scope
extern _enum_add_val
extern _new_node_for
global _ast_string_write
extern _env_clear_fn
extern _env_new
extern _stack_empty
extern _queue_length
global _write_string
global _ast_char_write
global _ast_div_write
global _ast_add_write
extern _env_register_scope
extern _new_node_sizeof
global _ast_switch_write
global _ast_eq_write
extern _env_get_type
extern _stack_new
extern _new_node_fn_arg
extern _new_node_break
extern _new_node_ternary
extern _new_node_arrow
extern _new_node_int
extern _scope_new
extern _peek
global _ast_neq_write
global _ast_gte_write
extern _type_get_size
extern _env_register_struct
extern _env_add_fn_arg
global _ast_statement_write
extern _push
extern _print_node
extern _type_print
extern _types_init
extern _hash_in
extern _queue_free
global _ast_call_write
extern _env_do_over_vars
extern _new_node_enum
extern _type_pointer_inner
global _write_env_vars
global _ast_decrement_write
global _ast_function_write
global _ast_dereference_write
global _ast_address_write
global _ast_sizeof_write
global _emit
extern _env_ast_type
extern _env_get_field
extern _env_add_global
extern _new_node_while
extern _is_scope
extern _queue_empty
global _ast_logical_or_write
extern _env_last_end
extern _env_num_args
extern _new_node_unop
global _ast_binop_write
global _ast_array_sub_write
extern _type_new_base
extern _hash_do_over
global _write_env_strings
global _ast_struct_write
global _ast_global_write
global _ast_assign_write
global _ast_logical_and_write
global _ast_gt_write
global _ast_lvalue_write
extern _new_node_function
extern _new_node_case
extern _node_call_enq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
extern _env_add_enum_value
extern _new_node_if
extern _printf
global _ast_for_write
extern _env_register_switch
extern _scope_find_local
extern _type_new_undet
extern _type_new_undet_struct
extern _env_register_typedef
global _ast_ternary_write
global _ast_negative_write
extern _new_node_declaration
extern _str_token_type
global _write_env_fns
extern _node_call_empty
extern _new_node_var
extern _type_new_struct
extern _strcmp
global _ast_logical_not_write
extern _sequence_enq
extern _node_call_deq
extern _enq
extern _token_new
extern _exit
