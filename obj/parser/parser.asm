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
	mov rax, 0
	mov rax, 35
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_16
	mov rax, 39
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_16:
	test rax, rax
	jnz label_15
	mov rax, 41
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_15:
	test rax, rax
	jnz label_14
	mov rax, 44
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_14:
	test rax, rax
	jnz label_13
	mov rax, 50
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_13:
	test rax, rax
	jnz label_12
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_17
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
label_17:
label_12:
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
	je label_18
	mov rax, 0
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-16], rax
	jmp label_19
label_18:
	mov rax, 39
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_20
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-16], rax
	jmp label_21
label_20:
	mov rax, 44
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_22
	mov rax, 2
	push rax
	pop rdi
	mov al, 0
	call _type_new_base
	mov [rbp-16], rax
	jmp label_23
label_22:
	mov rax, 50
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_24
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
	mov [rbp-16], rax
	jmp label_25
label_24:
	mov rax, 41
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
	mov [rbp-16], rax
	jmp label_27
label_26:
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
	mov [rbp-16], rax
label_27:
label_25:
label_23:
label_21:
label_19:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
label_28:
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
	je label_29
	mov rax, qword [rbp+8]
	push rax
	mov rax, 9
	push rax
	mov rax, _string_8
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
	mov [rbp-16], rax
	jmp label_28
label_29:
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
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_30
	mov rax, _string_9
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_30:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_deq
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
	mov rax, 0
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_31
	mov rax, 0
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
	je label_32
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_call
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_10
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_33:
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
	je label_34
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
	je label_35
	mov rax, qword [rbp+8]
	push rax
	mov rax, 30
	push rax
	mov rax, _string_11
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_35:
	jmp label_33
label_34:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_12
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	jmp label_36
label_32:
	mov rax, 0
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_var
	mov [rbp-16], rax
	mov rax, 0
label_36:
	jmp label_37
label_31:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_38
	mov rax, 0
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_int
	mov [rbp-16], rax
	mov rax, 0
	jmp label_39
label_38:
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_40
	mov rax, 0
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
	mov [rbp-16], rax
	jmp label_41
label_40:
	mov rax, 31
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_42
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _can_parse_type
	cmp rax, 0
	je label_43
	mov rax, 0
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
	mov rax, _string_12
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
	mov [rbp-16], rax
	jmp label_44
label_43:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_12
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_44:
	jmp label_45
label_42:
	mov rax, 2
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_46
	mov rax, 0
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _new_node_string
	mov [rbp-16], rax
	jmp label_47
label_46:
	mov rax, 42
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_48
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, 31
	push rax
	mov rax, _string_10
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
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_12
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	jmp label_49
label_48:
	mov rax, _string_13
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
label_49:
label_47:
label_45:
label_41:
label_39:
label_37:
	mov rax, 0
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _token_delete
	mov rax, 0
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
	mov rax, 0
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
label_50:
	mov rax, 24
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_54
	mov rax, 33
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_54:
	test rax, rax
	jnz label_53
	mov rax, 27
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_53:
	test rax, rax
	jnz label_52
	mov rax, 26
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_52:
	cmp rax, 0
	je label_51
	mov rax, 24
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_55
	mov rax, qword [rbp+8]
	push rax
	mov rax, 24
	push rax
	mov rax, _string_14
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
	je label_56
	mov rax, _string_15
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
label_56:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _new_node_arrow
	mov [rbp-8], rax
	jmp label_57
label_55:
	mov rax, 33
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_58
	mov rax, qword [rbp+8]
	push rax
	mov rax, 33
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
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 34
	push rax
	mov rax, _string_17
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
	mov [rbp-8], rax
	jmp label_59
label_58:
	mov rax, 27
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
	mov rax, 27
	push rax
	mov rax, _string_18
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
	mov [rbp-8], rax
	jmp label_61
label_60:
	mov rax, 26
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_62
	mov rax, qword [rbp+8]
	push rax
	mov rax, 26
	push rax
	mov rax, _string_19
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
	mov [rbp-8], rax
label_62:
label_61:
label_59:
label_57:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_50
label_51:
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
	mov rax, 0
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
	je label_63
	mov rax, qword [rbp+8]
	push rax
	mov rax, 11
	push rax
	mov rax, _string_20
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
	jmp label_64
label_63:
	mov rax, 9
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_65
	mov rax, qword [rbp+8]
	push rax
	mov rax, 9
	push rax
	mov rax, _string_8
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
	jmp label_66
label_65:
	mov rax, 17
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_67
	mov rax, qword [rbp+8]
	push rax
	mov rax, 17
	push rax
	mov rax, _string_21
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
	jmp label_68
label_67:
	mov rax, 8
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_69
	mov rax, qword [rbp+8]
	push rax
	mov rax, 8
	push rax
	mov rax, _string_22
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
	jmp label_70
label_69:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_unary_postfix
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_70:
label_68:
label_66:
label_64:
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
	mov rax, 0
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
label_71:
	mov rax, 9
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_73
	mov rax, 10
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_73:
	cmp rax, 0
	je label_72
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
	jz label_74
	mov rax, 16
	jmp label_75
label_74:
	mov rax, 17
label_75:
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
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_71
label_72:
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
	mov rax, 0
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
label_76:
	mov rax, 7
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_78
	mov rax, 8
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_78:
	cmp rax, 0
	je label_77
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
	jz label_79
	mov rax, 18
	jmp label_80
label_79:
	mov rax, 19
label_80:
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
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_76
label_77:
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
	mov rax, 0
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
label_81:
	mov rax, 20
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_85
	mov rax, 22
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_85:
	test rax, rax
	jnz label_84
	mov rax, 21
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_84:
	test rax, rax
	jnz label_83
	mov rax, 23
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
	mov [rbp-32], rax
	jmp label_86
switch_0_case_1:
	mov rax, 21
	mov [rbp-32], rax
	jmp label_86
switch_0_case_2:
	mov rax, 22
	mov [rbp-32], rax
	jmp label_86
switch_0_case_3:
	mov rax, 23
	mov [rbp-32], rax
	jmp label_86
switch_0_default:
	jmp label_86
label_86:
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
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_81
label_82:
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
	mov rax, 0
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
label_87:
	mov rax, 16
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_89
	mov rax, 19
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_89:
	cmp rax, 0
	je label_88
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
	mov [rbp-32], rax
	jmp label_90
switch_1_case_1:
	mov rax, 25
	mov [rbp-32], rax
	jmp label_90
switch_1_default:
	jmp label_90
label_90:
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
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_87
label_88:
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
	mov rax, 0
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
label_91:
	mov rax, 13
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
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_91
label_92:
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
	mov rax, 0
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
label_93:
	mov rax, 14
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
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _safe_peek_type
	mov [rbp-16], rax
	jmp label_93
label_94:
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
	mov rax, 0
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
	je label_95
	mov rax, qword [rbp+8]
	push rax
	mov rax, 29
	push rax
	mov rax, _string_23
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
	mov rax, _string_24
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
	mov [rbp-8], rax
label_95:
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
	mov rax, 0
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
	je label_96
	mov rax, qword [rbp+8]
	push rax
	mov rax, 15
	push rax
	mov rax, _string_25
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
	je label_97
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
label_97:
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
	mov [rbp-8], rax
label_96:
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
	mov rax, 0
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
	mov rax, 0
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
	je label_98
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	jmp label_99
label_98:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 15
	push rax
	mov rax, _string_25
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
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
label_99:
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, 4
	push rax
	mov rax, _string_27
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _new_node_sequence
	mov [rbp-8], rax
label_100:
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
	je label_101
	mov rax, 0
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
	jmp label_100
label_101:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_28
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, 0
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
	mov rax, _string_29
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
	mov rax, _string_10
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
	mov rax, _string_12
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
	je label_102
	mov rax, qword [rbp+8]
	push rax
	mov rax, 40
	push rax
	mov rax, _string_30
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
	mov [rbp-24], rax
label_102:
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
	mov rax, _string_31
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
	mov rax, _string_10
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
	mov rax, _string_12
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
	mov rax, _string_32
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
	je label_103
	mov rax, _string_33
	push rax
	pop rdi
	mov al, 0
	call _new_node_int
	mov [rbp-8], rax
	jmp label_104
label_103:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_expr
	mov [rbp-8], rax
label_104:
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
	mov rax, _string_34
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
	mov rax, _string_10
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
	mov rax, _string_12
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
	mov rax, _string_35
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
	mov rax, _string_36
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
	je label_105
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	mov [rbp-16], rax
	jmp label_106
label_105:
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_107
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	mov [rbp-16], rax
	jmp label_108
label_107:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_109
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
	je label_110
	mov rax, _string_37
	push rax
	pop rdi
	mov al, 0
	call _err
	jmp label_111
label_110:
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
	mov [rbp-16], rax
label_111:
	jmp label_112
label_109:
	mov rax, _string_38
	push rax
	pop rdi
	mov al, 0
	call _err
label_112:
label_108:
label_106:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 28
	push rax
	mov rax, _string_24
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _new_node_sequence
	mov [rbp-24], rax
label_113:
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
	jz label_116
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
label_116:
	test rax, rax
	jz label_115
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
label_115:
	cmp rax, 0
	je label_114
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
	jmp label_113
label_114:
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
	mov rax, _string_39
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
	mov rax, _string_10
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
	mov rax, _string_12
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
	mov rax, _string_27
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _queue_new
	mov [rbp-16], rax
label_117:
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
	je label_118
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
	jmp label_117
label_118:
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
	je label_119
	mov rax, qword [rbp+8]
	push rax
	mov rax, 48
	push rax
	mov rax, _string_40
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
	mov rax, _string_24
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_120:
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
	je label_121
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
	jmp label_120
label_121:
label_119:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_28
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
	mov rax, 0
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
	je label_122
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_123
label_122:
	mov rax, 4
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_124
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_sequence
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_125
label_124:
	mov rax, 36
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_126
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_if
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_127
label_126:
	mov rax, 37
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_128
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_while
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_129
label_128:
	mov rax, 38
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_130
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_return
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_131
label_130:
	mov rax, 45
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_132
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_for
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_133
label_132:
	mov rax, 49
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_134
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_break
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_135
label_134:
	mov rax, 46
	push rax
	mov rax, qword [rbp-8]
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
	call _parse_switch
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_137
label_136:
	mov rax, 0
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
label_137:
label_135:
label_133:
label_131:
label_129:
label_127:
label_125:
label_123:
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
	mov rax, _string_10
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov al, 0
	call _queue_new
	mov [rbp-8], rax
label_138:
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
	je label_139
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
	je label_140
	mov rax, _string_41
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_140:
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
	je label_141
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _deq
label_141:
	jmp label_138
label_139:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 32
	push rax
	mov rax, _string_12
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
	je label_142
	mov rax, 0
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
	je label_143
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_sequence
	mov [rbp-40], rax
	jmp label_144
label_143:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
label_144:
	mov rax, 0
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
	jmp label_145
label_142:
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
	je label_146
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
	jmp label_147
label_146:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 15
	push rax
	mov rax, _string_25
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
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _expect_semicolon
label_147:
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
label_145:
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
	mov rax, _string_42
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
	mov rax, _string_27
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
label_148:
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
	je label_149
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
	je label_150
	mov rax, _string_41
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_150:
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
	jmp label_148
label_149:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_28
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
	mov rax, _string_43
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
	mov rax, _string_44
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_45
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
	mov rax, _string_27
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
label_151:
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
	je label_152
	mov rax, qword [rbp+8]
	push rax
	mov rax, _string_46
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
	je label_153
	mov rax, qword [rbp+8]
	push rax
	mov rax, 30
	push rax
	mov rax, _string_11
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _expect
label_153:
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
	jmp label_151
label_152:
	mov rax, qword [rbp+8]
	push rax
	mov rax, 5
	push rax
	mov rax, _string_28
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
	je label_154
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_struct_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_155
label_154:
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
	je label_156
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_typedef
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_157
label_156:
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
	je label_158
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_enum
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	jmp label_159
label_158:
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _parse_top_declaration
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_159:
label_157:
label_155:
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
	je label_160
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	mov [g2], rax
label_160:
	mov rax, 0
	push rax
	mov rax, qword [g1]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_161
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	mov [g1], rax
label_161:
	mov rax, 0
	push rax
	mov rax, qword [g3]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_162
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	mov [g3], rax
label_162:
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
	_string_24: db 58, 0
	_string_19: db 43, 43, 0
	_string_6: db 59, 0
	_string_45: db 69, 110, 117, 109, 32, 110, 97, 109, 101, 32, 109, 117, 115, 116, 32, 98, 101, 32, 118, 97, 108, 105, 100, 0
	_string_25: db 61, 0
	_string_16: db 91, 0
	_string_46: db 69, 110, 117, 109, 32, 118, 97, 108, 32, 109, 117, 115, 116, 32, 98, 101, 32, 97, 32, 110, 97, 109, 101, 0
	_string_29: db 105, 102, 0
	_string_27: db 123, 0
	_string_23: db 63, 0
	_string_21: db 33, 0
	_string_17: db 93, 0
	_string_37: db 79, 110, 108, 121, 32, 105, 110, 116, 101, 103, 101, 114, 115, 32, 97, 108, 108, 111, 119, 101, 100, 32, 97, 115, 32, 99, 97, 115, 101, 115, 0
	_string_3: db 112, 97, 114, 115, 101, 114, 47, 112, 97, 114, 115, 101, 114, 46, 99, 0
	_string_28: db 125, 0
	_string_4: db 116, 111, 107, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_18: db 45, 45, 0
	_string_15: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 110, 97, 109, 101, 32, 102, 111, 114, 32, 102, 105, 101, 108, 100, 44, 32, 102, 111, 117, 110, 100, 32, 116, 121, 112, 101, 32, 37, 105, 10, 0
	_string_2: db 78, 111, 116, 32, 101, 110, 111, 117, 103, 104, 32, 116, 111, 107, 101, 110, 115, 32, 105, 110, 32, 113, 117, 101, 117, 101, 32, 102, 111, 114, 32, 116, 104, 105, 115, 32, 111, 112, 101, 114, 97, 116, 105, 111, 110, 0
	_string_20: db 38, 0
	_string_34: db 102, 111, 114, 0
	_string_10: db 40, 0
	_string_42: db 115, 116, 114, 117, 99, 116, 0
	_string_40: db 100, 101, 102, 97, 117, 108, 116, 0
	_string_12: db 41, 0
	_string_8: db 42, 0
	_string_11: db 44, 0
	_string_7: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 97, 110, 32, 108, 118, 97, 108, 117, 101, 10, 0
	_string_43: db 116, 121, 112, 101, 100, 101, 102, 0
	_string_22: db 45, 0
	_string_31: db 119, 104, 105, 108, 101, 0
	_string_33: db 48, 0
	_string_13: db 65, 121, 32, 110, 111, 33, 32, 101, 120, 112, 101, 99, 116, 101, 100, 32, 97, 32, 110, 97, 109, 101, 32, 111, 114, 32, 110, 117, 109, 98, 101, 114, 44, 32, 102, 111, 117, 110, 100, 32, 37, 115, 10, 0
	_string_26: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 108, 118, 97, 108, 117, 101, 10, 0
	_string_39: db 115, 119, 105, 116, 99, 104, 0
	_string_38: db 79, 110, 108, 121, 32, 105, 110, 116, 101, 103, 101, 114, 115, 32, 97, 108, 108, 111, 119, 101, 100, 32, 97, 115, 32, 99, 97, 115, 101, 115, 10, 0
	_string_36: db 99, 97, 115, 101, 0
	_string_5: db 37, 115, 32, 101, 120, 112, 101, 99, 116, 101, 100, 44, 32, 102, 111, 117, 110, 100, 32, 37, 115, 10, 0
	_string_41: db 69, 120, 112, 101, 99, 116, 101, 100, 32, 118, 97, 114, 105, 97, 98, 108, 101, 32, 110, 97, 109, 101, 10, 0
	_string_9: db 85, 104, 32, 111, 104, 33, 32, 114, 97, 110, 32, 111, 117, 116, 32, 111, 102, 32, 105, 110, 112, 117, 116, 0
	_string_1: db 37, 115, 0
	_string_35: db 98, 114, 101, 97, 107, 0
	_string_30: db 101, 108, 115, 101, 0
	_string_14: db 45, 62, 0
	_string_44: db 101, 110, 117, 109, 0
	_string_32: db 114, 101, 116, 117, 114, 110, 0
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
