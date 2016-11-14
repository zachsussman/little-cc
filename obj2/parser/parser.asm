default rel
section .text

_err:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_safe_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	cmp rax, 0
	je label_1
	mov rax, _string_2
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_1:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _token_deq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_get_name:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-8], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_2
	mov rax, _string_1
	push rax
	mov rax, qword [rbp+16]
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
label_2:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_safe_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	cmp rax, 0
	je label_3
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_3:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _token_peek
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_safe_peek_type:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	cmp rax, 0
	je label_4
	mov rax, 51
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_5
label_4:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek
	mov rax, [rax+0]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_5:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_expect:
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
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-8], rax
	mov rax, _string_3
	push rax
	mov rax, 54
	push rax
	mov rax, _string_4
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
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_6
	mov rax, _string_5
	push rax
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
	jmp label_7
label_6:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _token_delete
label_7:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_expect_semicolon:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 6
	push rax
	mov rax, _string_6
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_is_lvalue:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 1
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_10
	mov rax, 14
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_10:
	test rax, rax
	jnz label_9
	mov rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_9:
	test rax, rax
	jnz label_8
	mov rax, 9
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_8:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_check_is_lvalue:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_lvalue
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_11
	mov rax, _string_7
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_11:
	mov rax, qword [rbp+8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_can_parse_type:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek
	mov [rbp-16], rax
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 90
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_13
	mov rax, 1
	push rax
	mov rax, _string_9
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_13:
	test rax, rax
	jz label_12
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_12:
	mov rax, 35
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_18
	mov rax, 39
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_18:
	test rax, rax
	jnz label_17
	mov rax, 41
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_17:
	test rax, rax
	jnz label_16
	mov rax, 44
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_16:
	test rax, rax
	jnz label_15
	mov rax, 50
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_15:
	test rax, rax
	jnz label_14
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_19
	mov rax, 0
	push rax
	mov rax, qword [g1]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_19:
label_14:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_type:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-8], rax
	mov rax, 35
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_20
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_21
label_20:
	mov rax, 39
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_22
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_23
label_22:
	mov rax, 44
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_24
	mov rax, 2
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_25
label_24:
	mov rax, 50
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_26
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_27
label_26:
	mov rax, 41
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_28
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _type_new_undet_struct
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_29
label_28:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _type_new_undet
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_29:
label_27:
label_25:
label_23:
label_21:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
label_30:
	mov rax, 9
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_31
	mov rax, qword [rbp+8]
	push rax
	mov rax, 9
	push rax
	mov rax, _string_11
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _type_new_pointer
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_30
label_31:
	mov rax, qword [rbp-16]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_parens:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 124
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_33
	mov rax, 1
	push rax
	mov rax, _string_12
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_33:
	test rax, rax
	jz label_32
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_32:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_34
	mov rax, _string_13
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_34:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 134
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_36
	mov rax, 1
	push rax
	mov rax, _string_14
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_36:
	test rax, rax
	jz label_35
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_35:
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_37
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 137
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_39
	mov rax, 1
	push rax
	mov rax, _string_15
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_39:
	test rax, rax
	jz label_38
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_38:
	mov rax, 31
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_40
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_call
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_41:
	mov rax, 32
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_42
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _node_call_enq
	mov rax, 30
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_43
	mov rax, qword [rbp+8]
	push rax
	mov rax, 30
	push rax
	mov rax, _string_17
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_43:
	jmp label_41
label_42:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	jmp label_44
label_40:
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 149
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_46
	mov rax, 1
	push rax
	mov rax, _string_19
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_46:
	test rax, rax
	jz label_45
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_45:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_var
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 151
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_48
	mov rax, 1
	push rax
	mov rax, _string_20
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_48:
	test rax, rax
	jz label_47
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_47:
label_44:
	jmp label_49
label_37:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_50
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 155
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_52
	mov rax, 1
	push rax
	mov rax, _string_21
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_52:
	test rax, rax
	jz label_51
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_51:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_int
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 157
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_54
	mov rax, 1
	push rax
	mov rax, _string_22
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_54:
	test rax, rax
	jz label_53
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_53:
	jmp label_55
label_50:
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_56
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 160
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_58
	mov rax, 1
	push rax
	mov rax, _string_23
	push rax
	mov rax, 0
	imul rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_58:
	test rax, rax
	jz label_57
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_57:
	mov rax, 0
	imul rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _new_node_char
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_59
label_56:
	mov rax, 31
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_60
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 164
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_62
	mov rax, 1
	push rax
	mov rax, _string_24
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_62:
	test rax, rax
	jz label_61
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_61:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _can_parse_type
	cmp rax, 0
	je label_63
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 167
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_65
	mov rax, 1
	push rax
	mov rax, _string_25
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_65:
	test rax, rax
	jz label_64
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_64:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	mov [rbp-32], rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_cast
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_66
label_63:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_66:
	jmp label_67
label_60:
	mov rax, 2
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_68
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 179
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_70
	mov rax, 1
	push rax
	mov rax, _string_26
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_70:
	test rax, rax
	jz label_69
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_69:
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_string
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
label_68:
	mov rax, 42
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_72
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 183
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_74
	mov rax, 1
	push rax
	mov rax, _string_27
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_74:
	test rax, rax
	jz label_73
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_73:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	push rax
	pop rdi
	mov al, 0
	call _new_node_sizeof
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	jmp label_75
label_72:
	mov rax, _string_28
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
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
label_75:
label_71:
label_67:
label_59:
label_55:
label_49:
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 192
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_77
	mov rax, 1
	push rax
	mov rax, _string_29
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_77:
	test rax, rax
	jz label_76
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_76:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 194
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_79
	mov rax, 1
	push rax
	mov rax, _string_30
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_79:
	test rax, rax
	jz label_78
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_78:
	mov rax, qword [rbp-16]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_unary_postfix:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 200
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_81
	mov rax, 1
	push rax
	mov rax, _string_31
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_81:
	test rax, rax
	jz label_80
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_80:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_parens
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_82:
	mov rax, 24
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_86
	mov rax, 33
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_86:
	test rax, rax
	jnz label_85
	mov rax, 27
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_85:
	test rax, rax
	jnz label_84
	mov rax, 26
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_84:
	cmp rax, 0
	je label_83
	mov rax, 24
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_87
	mov rax, qword [rbp+8]
	push rax
	mov rax, 24
	push rax
	mov rax, _string_32
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-24], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_88
	mov rax, _string_33
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
label_88:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_arrow
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	jmp label_89
label_87:
	mov rax, 33
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_90
	mov rax, qword [rbp+8]
	push rax
	mov rax, 33
	push rax
	mov rax, _string_34
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 34
	push rax
	mov rax, _string_35
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 9
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	jmp label_91
label_90:
	mov rax, 27
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_92
	mov rax, qword [rbp+8]
	push rax
	mov rax, 27
	push rax
	mov rax, _string_36
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 11
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	jmp label_93
label_92:
	mov rax, 26
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_94
	mov rax, qword [rbp+8]
	push rax
	mov rax, 26
	push rax
	mov rax, _string_37
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 10
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
label_94:
label_93:
label_91:
label_89:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_82
label_83:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_unary_prefix:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 232
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_96
	mov rax, 1
	push rax
	mov rax, _string_38
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_96:
	test rax, rax
	jz label_95
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_95:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-8], rax
	mov rax, 11
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_97
	mov rax, qword [rbp+8]
	push rax
	mov rax, 11
	push rax
	mov rax, _string_39
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 13
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	push rax
	pop rdi
	mov al, 0
	call _check_is_lvalue
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_98
label_97:
	mov rax, 9
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_99
	mov rax, qword [rbp+8]
	push rax
	mov rax, 9
	push rax
	mov rax, _string_11
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 14
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_100
label_99:
	mov rax, 17
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_101
	mov rax, qword [rbp+8]
	push rax
	mov rax, 17
	push rax
	mov rax, _string_40
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 15
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_102
label_101:
	mov rax, 8
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_103
	mov rax, qword [rbp+8]
	push rax
	mov rax, 8
	push rax
	mov rax, _string_41
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 12
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_104
label_103:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_postfix
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_104:
label_102:
label_100:
label_98:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_mul:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 254
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_106
	mov rax, 1
	push rax
	mov rax, _string_42
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_106:
	test rax, rax
	jz label_105
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_105:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_107:
	mov rax, 9
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_109
	mov rax, 10
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_109:
	cmp rax, 0
	je label_108
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_prefix
	mov [rbp-24], rax
	mov rax, 9
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_110
	mov rax, 16
	jmp label_111
label_110:
	mov rax, 17
label_111:
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_107
label_108:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_add:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 269
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_113
	mov rax, 1
	push rax
	mov rax, _string_43
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_113:
	test rax, rax
	jz label_112
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_112:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_mul
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_114:
	mov rax, 7
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_116
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_116:
	cmp rax, 0
	je label_115
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_mul
	mov [rbp-24], rax
	mov rax, 7
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_117
	mov rax, 18
	jmp label_118
label_117:
	mov rax, 19
label_118:
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_114
label_115:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_comparisons:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 284
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_120
	mov rax, 1
	push rax
	mov rax, _string_44
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_120:
	test rax, rax
	jz label_119
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_119:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_add
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_121:
	mov rax, 20
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_125
	mov rax, 22
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_125:
	test rax, rax
	jnz label_124
	mov rax, 21
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_124:
	test rax, rax
	jnz label_123
	mov rax, 23
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_123:
	cmp rax, 0
	je label_122
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_add
	mov [rbp-24], rax
	mov rax, qword [rbp-16]
	cmp rax, 20
	je switch_0_case_0
	cmp rax, 22
	je switch_0_case_1
	cmp rax, 21
	je switch_0_case_2
	cmp rax, 23
	je switch_0_case_3
	jmp switch_0_default
switch_0_case_0:
	mov rax, 20
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_126
switch_0_case_1:
	mov rax, 21
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_126
switch_0_case_2:
	mov rax, 22
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_126
switch_0_case_3:
	mov rax, 23
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_126
switch_0_default:
	jmp label_126
label_126:
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_121
label_122:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_eqs:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 309
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_128
	mov rax, 1
	push rax
	mov rax, _string_45
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_128:
	test rax, rax
	jz label_127
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_127:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_comparisons
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_129:
	mov rax, 16
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_131
	mov rax, 19
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_131:
	cmp rax, 0
	je label_130
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_add
	mov [rbp-24], rax
	mov rax, qword [rbp-16]
	cmp rax, 16
	je switch_1_case_0
	cmp rax, 19
	je switch_1_case_1
	jmp switch_1_default
switch_1_case_0:
	mov rax, 24
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_132
switch_1_case_1:
	mov rax, 25
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	jmp label_132
switch_1_default:
	jmp label_132
label_132:
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_129
label_130:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_logical_and:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 332
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_134
	mov rax, 1
	push rax
	mov rax, _string_46
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_134:
	test rax, rax
	jz label_133
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_133:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_eqs
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_135:
	mov rax, 13
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_136
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_eqs
	mov [rbp-24], rax
	mov rax, 26
	mov [rbp-32], rax
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_135
label_136:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_logical_or:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 350
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_138
	mov rax, 1
	push rax
	mov rax, _string_47
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_138:
	test rax, rax
	jz label_137
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_137:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_logical_and
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
label_139:
	mov rax, 14
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_140
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_eqs
	mov [rbp-24], rax
	mov rax, 27
	mov [rbp-32], rax
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_139
label_140:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_ternary:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 368
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_142
	mov rax, 1
	push rax
	mov rax, _string_48
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_142:
	test rax, rax
	jz label_141
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_141:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_logical_or
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	mov rax, 29
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_143
	mov rax, qword [rbp+8]
	push rax
	mov rax, 29
	push rax
	mov rax, _string_49
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 28
	push rax
	mov rax, _string_50
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-32], rax
	mov rax, 28
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_ternary
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
label_143:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_assign:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 383
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_145
	mov rax, 1
	push rax
	mov rax, _string_51
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_145:
	test rax, rax
	jz label_144
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_144:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_ternary
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	mov rax, 15
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_146
	mov rax, qword [rbp+8]
	push rax
	mov rax, 15
	push rax
	mov rax, _string_52
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_lvalue
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_147
	mov rax, _string_53
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_147:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_assign
	mov [rbp-24], rax
	mov rax, 29
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_binop
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
label_146:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_declaration:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 402
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_149
	mov rax, 1
	push rax
	mov rax, _string_54
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_149:
	test rax, rax
	jz label_148
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_148:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-24], rax
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 407
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_151
	mov rax, 1
	push rax
	mov rax, _string_55
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_151:
	test rax, rax
	jz label_150
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_150:
	mov rax, 0
	mov [rbp-32], rax
	mov rax, 6
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_152
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	jmp label_153
label_152:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 15
	push rax
	mov rax, _string_52
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
label_153:
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 416
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_155
	mov rax, 1
	push rax
	mov rax, _string_56
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_155:
	test rax, rax
	jz label_154
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_154:
	mov rax, 30
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_expr:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_assign
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_sequence:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 425
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_157
	mov rax, 1
	push rax
	mov rax, _string_57
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_157:
	test rax, rax
	jz label_156
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_156:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 4
	push rax
	mov rax, _string_58
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _new_node_sequence
	mov [rbp-8], rax
label_158:
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_159
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 429
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_161
	mov rax, 1
	push rax
	mov rax, _string_59
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_161:
	test rax, rax
	jz label_160
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_160:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	mov [rbp-16], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _sequence_enq
	jmp label_158
label_159:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_60
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 434
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_163
	mov rax, 1
	push rax
	mov rax, _string_61
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_163:
	test rax, rax
	jz label_162
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_162:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_if:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 36
	push rax
	mov rax, _string_62
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	mov [rbp-16], rax
	mov rax, 0
	mov [rbp-24], rax
	mov rax, 40
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_164
	mov rax, qword [rbp+8]
	push rax
	mov rax, 40
	push rax
	mov rax, _string_63
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
label_164:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_if
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_while:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 37
	push rax
	mov rax, _string_64
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	mov [rbp-16], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_while
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_return:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 38
	push rax
	mov rax, _string_65
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 6
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_165
	mov rax, _string_66
	push rax
	pop rdi
	mov al, 0
	call _new_node_int
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	jmp label_166
label_165:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
label_166:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 6
	push rax
	mov rax, _string_6
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 34
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_unop
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_for:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 45
	push rax
	mov rax, _string_67
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 6
	push rax
	mov rax, _string_6
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	mov [rbp-32], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_for
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_break:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 49
	push rax
	mov rax, _string_68
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	mov al, 0
	call _new_node_break
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_case:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 47
	push rax
	mov rax, _string_69
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
	mov rax, 2
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_167
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_168
label_167:
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_169
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_170
label_169:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_171
	mov rax, qword [g3]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_in
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_172
	mov rax, _string_70
	push rax
	pop rdi
	mov al, 0
	call _err
	jmp label_173
label_172:
	mov rax, qword [g3]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_173:
	jmp label_174
label_171:
	mov rax, _string_71
	push rax
	pop rdi
	mov al, 0
	call _err
label_174:
label_170:
label_168:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 28
	push rax
	mov rax, _string_50
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _new_node_sequence
	mov [rbp-24], rax
label_175:
	mov rax, 47
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_178
	mov rax, 48
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_178:
	test rax, rax
	jz label_177
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_177:
	cmp rax, 0
	je label_176
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _sequence_enq
	jmp label_175
label_176:
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_case
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_switch:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 46
	push rax
	mov rax, _string_72
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 4
	push rax
	mov rax, _string_58
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _queue_new
	mov [rbp-16], rax
label_179:
	mov rax, 47
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_180
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_case
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_179
label_180:
	mov al, 0
	call _new_node_sequence
	mov [rbp-24], rax
	mov rax, 48
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_181
	mov rax, qword [rbp+8]
	push rax
	mov rax, 48
	push rax
	mov rax, _string_73
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 28
	push rax
	mov rax, _string_50
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_182:
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_183
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_statement
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _sequence_enq
	jmp label_182
label_183:
label_181:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_60
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_switch
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_statement:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 541
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_185
	mov rax, 1
	push rax
	mov rax, _string_74
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_185:
	test rax, rax
	jz label_184
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_184:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _can_parse_type
	cmp rax, 0
	je label_186
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_187
label_186:
	mov rax, 4
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_188
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_sequence
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_189
label_188:
	mov rax, 36
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_190
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_if
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_191
label_190:
	mov rax, 37
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_192
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_while
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_193
label_192:
	mov rax, 38
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_194
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_return
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_195
label_194:
	mov rax, 45
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_196
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_for
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_197
label_196:
	mov rax, 49
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_198
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_break
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_199
label_198:
	mov rax, 46
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_200
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_switch
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_201
label_200:
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 563
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_203
	mov rax, 1
	push rax
	mov rax, _string_75
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_203:
	test rax, rax
	jz label_202
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_202:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _new_node_statement
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_201:
label_199:
label_197:
label_195:
label_193:
label_191:
label_189:
label_187:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_args:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_16
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _queue_new
	mov [rbp-8], rax
label_204:
	mov rax, 32
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_205
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-24], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_206
	mov rax, _string_76
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_206:
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	mov [rbp-32], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_fn_arg
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rax, 30
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_207
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _deq
label_207:
	jmp label_204
label_205:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_18
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_top_declaration:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 64
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-24], rax
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, 31
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_208
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 597
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_210
	mov rax, 1
	push rax
	mov rax, _string_77
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_210:
	test rax, rax
	jz label_209
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_209:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_args
	mov [rbp-32], rax
	mov rax, 0
	mov [rbp-40], rax
	mov rax, 6
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_211
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_sequence
	push rax
	lea rax, [rbp-40]
	pop rcx
	mov [rax], rcx
	jmp label_212
label_211:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
label_212:
	mov rax, _string_8
	push rax
	mov rax, _string_3
	push rax
	mov rax, 602
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	test rax, rax
	jz label_214
	mov rax, 1
	push rax
	mov rax, _string_78
	push rax
	pop rdi
	mov al, 0
	call _printf
	pop rcx
	add rax, rcx
label_214:
	test rax, rax
	jz label_213
	mov rax, _string_10
	push rax
	pop rdi
	mov al, 0
	call _printf
label_213:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_function
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_215
label_208:
	mov rax, 0
	mov [rbp-32], rax
	mov rax, 6
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_216
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	jmp label_217
label_216:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 15
	push rax
	mov rax, _string_52
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
label_217:
	mov rax, 40
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_declaration
	mov [rbp-40], rax
	mov rax, qword [rbp-40]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_215:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_struct_declaration:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 41
	push rax
	mov rax, _string_79
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 4
	push rax
	mov rax, _string_58
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _type_new_struct
	mov [rbp-16], rax
label_218:
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_219
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-32], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_220
	mov rax, _string_76
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_220:
	mov rax, qword [rbp-32]
	mov rax, [rax+8]
	mov [rbp-40], rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-40]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _type_add_field
	mov rax, qword [rbp+8]
	push rax
	mov rax, 6
	push rax
	mov rax, _string_6
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	jmp label_218
label_219:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_60
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, 6
	push rax
	mov rax, _string_6
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [g2]
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_struct
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_typedef:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 43
	push rax
	mov rax, _string_80
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_type
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 6
	push rax
	mov rax, _string_6
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [g1]
	push rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_typedef
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_enum:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 50
	push rax
	mov rax, _string_81
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_82
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _get_name
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 4
	push rax
	mov rax, _string_58
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_enum
	mov [rbp-16], rax
	mov rax, 0
	mov [rbp-24], rax
label_221:
	mov rax, 5
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_222
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_83
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _get_name
	mov [rbp-32], rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enum_add_val
	mov rax, 30
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_223
	mov rax, qword [rbp+8]
	push rax
	mov rax, 30
	push rax
	mov rax, _string_17
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_223:
	mov rax, qword [g3]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	lea rax, [rbp-24]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_221
label_222:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_60
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	mov rax, qword [rbp-16]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_top:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 41
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_224
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_struct_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_225
label_224:
	mov rax, 43
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_226
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_typedef
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_227
label_226:
	mov rax, 50
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_228
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_enum
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_229
label_228:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_top_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_229:
label_227:
label_225:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 0
	push rax
	mov rax, qword [g2]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_230
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, g2
	pop rcx
	mov [rax], rcx
label_230:
	mov rax, 0
	push rax
	mov rax, qword [g1]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_231
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, g1
	pop rcx
	mov [rax], rcx
label_231:
	mov rax, 0
	push rax
	mov rax, qword [g3]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_232
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	push rax
	mov rax, g3
	pop rcx
	mov [rax], rcx
label_232:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_top
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	g1: dq 0
	g3: dq 0
	g2: dq 0
	_string_57: db 80, 97, 114, 115, 105, 110, 103, 32, 115, 101, 113, 117, 101, 110, 99, 101, 46, 46, 46, 0
	_string_54: db 80, 97, 114, 115, 105, 110, 103, 32, 100, 101, 99, 108, 97, 114, 97, 116, 105, 111, 110, 46, 46, 46, 0
	_string_50: db 58, 0
	_string_37: db 43, 43, 0
	_string_22: db 67, 114, 101, 97, 116, 101, 100, 32, 110, 101, 119, 95, 110, 111, 100, 101, 95, 105, 110, 116, 0
	_string_6: db 59, 0
	_string_82: db 69, 110, 117, 109, 32, 110, 97, 109, 101, 32, 109, 117, 115, 116, 32, 98, 101, 32, 118, 97, 108, 105, 100, 0
	_string_77: db 80, 97, 114, 115, 105, 110, 103, 32, 102, 117, 110, 99, 116, 105, 111, 110, 46, 46, 46, 0
	_string_52: db 61, 0
	_string_34: db 91, 0
	_string_83: db 69, 110, 117, 109, 32, 118, 97, 108, 32, 109, 117, 115, 116, 32, 98, 101, 32, 97, 32, 110, 97, 109, 101, 0
	_string_62: db 105, 102, 0
	_string_58: db 123, 0
	_string_49: db 63, 0
	_string_40: db 33, 0
	_string_35: db 93, 0
	_string_78: db 80, 97, 114, 115, 101, 100, 32, 102, 117, 110, 99, 116, 105, 111, 110, 33, 0
	_string_70: db 79, 110, 108, 121, 32, 105, 110, 116, 101, 103, 101, 114, 115, 32, 97, 108, 108, 111, 119, 101, 100, 32, 97, 115, 32, 99, 97, 115, 101, 115, 0
	_string_24: db 70, 111, 117, 110, 100, 32, 112, 97, 114, 101, 110, 116, 104, 101, 115, 105, 122, 101, 100, 0
	_string_20: db 67, 114, 101, 97, 116, 101, 100, 32, 118, 97, 114, 105, 97, 98, 108, 101, 0
	_string_3: db 112, 97, 114, 115, 101, 114, 47, 112, 97, 114, 115, 101, 114, 46, 99, 0
	_string_74: db 80, 97, 114, 115, 105, 110, 103, 32, 115, 116, 97, 116, 101, 109, 101, 110, 116, 46, 46, 46, 0
	_string_60: db 125, 0
	_string_4: db 116, 111, 107, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_38: db 112, 114, 101, 102, 105, 120, 0
	_string_36: db 45, 45, 0
	_string_33: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 110, 97, 109, 101, 32, 102, 111, 114, 32, 102, 105, 101, 108, 100, 44, 32, 102, 111, 117, 110, 100, 32, 116, 121, 112, 101, 32, 37, 105, 10, 0
	_string_25: db 84, 104, 105, 115, 32, 105, 115, 32, 97, 32, 99, 97, 115, 116, 0
	_string_43: db 97, 100, 100, 0
	_string_23: db 70, 111, 117, 110, 100, 32, 99, 104, 97, 114, 97, 99, 116, 101, 114, 32, 37, 99, 0
	_string_2: db 78, 111, 116, 32, 101, 110, 111, 117, 103, 104, 32, 116, 111, 107, 101, 110, 115, 32, 105, 110, 32, 113, 117, 101, 117, 101, 32, 102, 111, 114, 32, 116, 104, 105, 115, 32, 111, 112, 101, 114, 97, 116, 105, 111, 110, 0
	_string_61: db 69, 110, 100, 32, 115, 101, 113, 117, 101, 110, 99, 101, 0
	_string_39: db 38, 0
	_string_67: db 102, 111, 114, 0
	_string_47: db 76, 79, 114, 0
	_string_75: db 80, 97, 114, 115, 105, 110, 103, 32, 101, 120, 112, 114, 101, 115, 115, 105, 111, 110, 46, 46, 46, 0
	_string_45: db 101, 113, 117, 97, 108, 105, 116, 121, 0
	_string_16: db 40, 0
	_string_10: db 10, 0
	_string_79: db 115, 116, 114, 117, 99, 116, 0
	_string_73: db 100, 101, 102, 97, 117, 108, 116, 0
	_string_18: db 41, 0
	_string_11: db 42, 0
	_string_48: db 84, 101, 114, 110, 97, 114, 121, 0
	_string_46: db 76, 97, 110, 100, 0
	_string_19: db 67, 114, 101, 97, 116, 105, 110, 103, 32, 118, 97, 114, 105, 97, 98, 108, 101, 46, 46, 46, 0
	_string_56: db 80, 97, 114, 115, 101, 100, 32, 116, 104, 101, 32, 115, 101, 99, 111, 110, 100, 32, 112, 97, 114, 116, 33, 0
	_string_17: db 44, 0
	_string_7: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 97, 110, 32, 108, 118, 97, 108, 117, 101, 10, 0
	_string_80: db 116, 121, 112, 101, 100, 101, 102, 0
	_string_41: db 45, 0
	_string_31: db 112, 111, 115, 116, 102, 105, 120, 0
	_string_64: db 119, 104, 105, 108, 101, 0
	_string_44: db 99, 111, 109, 112, 97, 114, 101, 0
	_string_26: db 70, 111, 117, 110, 100, 32, 115, 116, 114, 105, 110, 103, 58, 32, 34, 37, 115, 34, 0
	_string_15: db 70, 111, 117, 110, 100, 32, 110, 97, 109, 101, 58, 32, 37, 115, 0
	_string_66: db 48, 0
	_string_30: db 84, 111, 107, 101, 110, 32, 100, 101, 108, 101, 116, 101, 100, 0
	_string_28: db 65, 121, 32, 110, 111, 33, 32, 101, 120, 112, 101, 99, 116, 101, 100, 32, 97, 32, 110, 97, 109, 101, 32, 111, 114, 32, 110, 117, 109, 98, 101, 114, 44, 32, 102, 111, 117, 110, 100, 32, 37, 115, 10, 0
	_string_53: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 108, 118, 97, 108, 117, 101, 10, 0
	_string_29: db 68, 101, 108, 101, 116, 105, 110, 103, 32, 116, 111, 107, 101, 110, 46, 46, 46, 0
	_string_9: db 67, 97, 110, 32, 73, 32, 112, 97, 114, 115, 101, 32, 116, 104, 105, 115, 32, 116, 121, 112, 101, 63, 32, 37, 115, 0
	_string_72: db 115, 119, 105, 116, 99, 104, 0
	_string_71: db 79, 110, 108, 121, 32, 105, 110, 116, 101, 103, 101, 114, 115, 32, 97, 108, 108, 111, 119, 101, 100, 32, 97, 115, 32, 99, 97, 115, 101, 115, 10, 0
	_string_69: db 99, 97, 115, 101, 0
	_string_5: db 37, 115, 32, 101, 120, 112, 101, 99, 116, 101, 100, 44, 32, 102, 111, 117, 110, 100, 32, 37, 115, 10, 0
	_string_76: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 118, 97, 114, 105, 97, 98, 108, 101, 32, 110, 97, 109, 101, 10, 0
	_string_13: db 85, 104, 32, 111, 104, 33, 32, 114, 97, 110, 32, 111, 117, 116, 32, 111, 102, 32, 105, 110, 112, 117, 116, 0
	_string_27: db 70, 111, 117, 110, 100, 32, 115, 105, 122, 101, 111, 102, 0
	_string_14: db 68, 101, 113, 117, 101, 117, 101, 100, 0
	_string_1: db 37, 115, 0
	_string_68: db 98, 114, 101, 97, 107, 0
	_string_63: db 101, 108, 115, 101, 0
	_string_59: db 80, 97, 114, 115, 105, 110, 103, 32, 105, 110, 110, 101, 114, 32, 115, 116, 97, 116, 101, 109, 101, 110, 116, 46, 46, 46, 0
	_string_51: db 65, 115, 115, 105, 103, 110, 109, 101, 110, 116, 0
	_string_32: db 45, 62, 0
	_string_42: db 109, 117, 108, 0
	_string_8: db 37, 115, 58, 37, 100, 32, 9, 0
	_string_81: db 101, 110, 117, 109, 0
	_string_21: db 70, 111, 117, 110, 100, 32, 110, 117, 109, 98, 101, 114, 58, 32, 37, 115, 0
	_string_12: db 80, 97, 114, 101, 110, 115, 0
	_string_65: db 114, 101, 116, 117, 114, 110, 0
	_string_55: db 80, 97, 114, 115, 101, 100, 32, 116, 104, 101, 32, 102, 105, 114, 115, 116, 32, 112, 97, 114, 116, 33, 0
global _parse_parens
global _parse_expr
extern _new_node_typedef
extern _new_node_struct
extern _sequence_empty
extern _fprintf
extern _new_node_char
extern _hash_insert
extern _strdup
global _can_parse_type
extern _new_node_sequence
extern _new_node_string
extern _type_add_field
extern _hash_get
extern _my_assert
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
global _parse_typedef
global _parse_while
global _parse_eqs
global _parse_add
global _parse_unary_postfix
extern _strncmp
global _parse_case
global _parse_return
global _parse_comparisons
global _get_name
extern _sequence_deq
extern _scope_add_local
extern _type_get_field
extern _queue_test
extern _fclose
extern _getline
extern _free
global _parse_for
extern _type_new_pointer
extern _new_node_call
extern _type_new_fn
extern _strndup
global _parse_sequence
global _expect
global _parse_statement
extern _new_node_statement
extern _new_node_cast
extern _hash_new
extern _token_delete
global _parse_declaration
global _parse_unary_prefix
extern _new_node_switch
extern _new_node_binop
global _parse_top
global _parse_enum
extern _pop
extern _ast_construct_scope
extern _enum_add_val
extern _new_node_for
global _parse_switch
global _parse_type
extern _stack_empty
extern _queue_length
global _expect_semicolon
global _err
global _parse_struct_declaration
extern _new_node_sizeof
global _check_is_lvalue
extern _stack_new
extern _token_peek
extern _new_node_fn_arg
extern _new_node_break
extern _new_node_ternary
extern _new_node_arrow
extern _new_node_int
extern _scope_new
extern _peek
global _parse_top_declaration
global _safe_peek_type
global _safe_deq
extern _push
extern _print_node
extern _type_print
extern _types_init
extern _hash_in
extern _queue_free
global _parse_ternary
extern _new_node_enum
extern _type_pointer_inner
global _parse_assign
global _parse_logical_and
extern _new_node_while
extern _is_scope
extern _queue_empty
global _parse_mul
extern _new_node_unop
global _parse_args
extern _type_new_base
extern _hash_do_over
global _is_lvalue
extern _token_deq
extern _new_node_function
extern _new_node_case
extern _node_call_enq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
global _parse_if
extern _new_node_if
extern _printf
extern _scope_find_local
extern _type_new_undet
extern _type_new_undet_struct
global _parse_logical_or
global _safe_peek
global _parse
extern _new_node_declaration
extern _str_token_type
global _parse_break
extern _node_call_empty
extern _new_node_var
extern _type_new_struct
extern _strcmp
extern _token_enq
extern _sequence_enq
extern _node_call_deq
extern _enq
extern _token_new
extern _exit
