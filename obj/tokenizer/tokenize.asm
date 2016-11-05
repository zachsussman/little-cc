default rel
section .text

_is_whitespace:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 32
	push rax
	movzx rax, byte [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_2
	mov rax, 9
	push rax
	movzx rax, byte [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_2:
	test rax, rax
	jnz label_1
	mov rax, 10
	push rax
	movzx rax, byte [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
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
_is_char_in_range:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	movzx rax, byte [rbp+8]
	push rax
	movzx rax, byte [rbp+16]
	pop rcx
	cmp rax, rcx
	setle al
	movzx rax, al
	test rax, rax
	jz label_3
	movzx rax, byte [rbp+24]
	push rax
	movzx rax, byte [rbp+8]
	pop rcx
	cmp rax, rcx
	setle al
	movzx rax, al
label_3:
	add rsp, 0
	pop rbp
	add rsp, 32
	ret
	add rsp, 0
	pop rbp
	add rsp, 32
	ret
_is_beginning_name_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	movzx rax, byte [rbp+8]
	push rax
	mov rax, 95
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_5
	movzx rax, byte [rbp+8]
	push rax
	mov rax, 97
	push rax
	mov rax, 122
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _is_char_in_range
label_5:
	test rax, rax
	jnz label_4
	movzx rax, byte [rbp+8]
	push rax
	mov rax, 65
	push rax
	mov rax, 90
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _is_char_in_range
label_4:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_is_number_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	movzx rax, byte [rbp+8]
	push rax
	mov rax, 48
	push rax
	mov rax, 57
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _is_char_in_range
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_is_name_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	movzx rax, byte [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_beginning_name_char
	test rax, rax
	jnz label_6
	movzx rax, byte [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_number_char
label_6:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_inspect_for_keywords:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _peek
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
	je label_7
	mov rax, 0
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
label_7:
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_parse_number:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, 0
	mov [rbp-8], rax
label_8:
	mov rax, 80
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_11
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_11:
	test rax, rax
	jz label_10
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _is_number_char
label_10:
	cmp rax, 0
	je label_9
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_8
label_9:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	add rax, rcx
	push rax
	mov rax, 1
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _calloc
	mov [rbp-16], rax
	mov rax, 0
	mov [rbp-24], rax
label_12:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_15
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_15:
	test rax, rax
	jz label_14
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _is_number_char
label_14:
	cmp rax, 0
	je label_13
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	mov rax, qword [rbp-24]
	imul rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	lea rax, [rbp-24]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_12
label_13:
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, 1
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	mov [rbp-32], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
_parse_name:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, 0
	mov [rbp-8], rax
label_16:
	mov rax, 80
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_19
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_19:
	test rax, rax
	jz label_18
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _is_name_char
label_18:
	cmp rax, 0
	je label_17
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_16
label_17:
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	add rax, rcx
	push rax
	mov rax, 1
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _calloc
	mov [rbp-16], rax
	mov rax, 0
	mov [rbp-24], rax
label_20:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_23
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_23:
	test rax, rax
	jz label_22
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _is_name_char
label_22:
	cmp rax, 0
	je label_21
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	mov rax, qword [rbp-24]
	imul rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	lea rax, [rbp-24]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_20
label_21:
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_1
	push rax
	mov rax, 4
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _strncmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_24
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 34
	push rax
	mov rax, _string_1
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rax, 0
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
	jmp label_25
label_24:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_2
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_26
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 35
	push rax
	mov rax, _string_2
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_27
label_26:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_3
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_28
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 36
	push rax
	mov rax, _string_3
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_29
label_28:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_4
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_30
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 37
	push rax
	mov rax, _string_4
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_31
label_30:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_5
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_32
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 38
	push rax
	mov rax, _string_5
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_33
label_32:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_6
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_34
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 39
	push rax
	mov rax, _string_6
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_35
label_34:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_7
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_36
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 40
	push rax
	mov rax, _string_7
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_37
label_36:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_8
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_38
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 41
	push rax
	mov rax, _string_8
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_39
label_38:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_9
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_40
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 42
	push rax
	mov rax, _string_9
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_41
label_40:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_10
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_42
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 44
	push rax
	mov rax, _string_10
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_43
label_42:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_11
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_44
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 45
	push rax
	mov rax, _string_11
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_45
label_44:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_12
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_46
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 46
	push rax
	mov rax, _string_12
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_47
label_46:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_13
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_48
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 47
	push rax
	mov rax, _string_13
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_49
label_48:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_14
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_50
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 48
	push rax
	mov rax, _string_14
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_51
label_50:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_15
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_52
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 43
	push rax
	mov rax, _string_15
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_53
label_52:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_16
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_54
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 49
	push rax
	mov rax, _string_16
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_55
label_54:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	mov [rbp-32], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
label_55:
label_53:
label_51:
label_49:
label_47:
label_45:
label_43:
label_41:
label_39:
label_37:
label_35:
label_33:
label_31:
label_29:
label_27:
label_25:
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
_parse_string_advance:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov [rbp-8], rax
	mov rax, 92
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_56
	mov rax, qword [rbp+8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	mov rax, 110
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_57
	mov rax, 10
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], cl
	jmp label_58
label_57:
	mov rax, 116
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_59
	mov rax, 9
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], cl
	jmp label_60
label_59:
	mov rax, 48
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_61
	mov rax, 0
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], cl
	jmp label_62
label_61:
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], cl
label_62:
label_60:
label_58:
	jmp label_63
label_56:
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], cl
label_63:
	mov rax, qword [rbp+8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	movzx rax, byte [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_parse_string:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov rax, 0
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	mov [rbp-16], rax
	lea rax, [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
label_64:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_66
	mov rax, 34
	push rax
	mov rax, qword [rbp-16]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_66:
	cmp rax, 0
	je label_65
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	lea rax, [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	jmp label_64
label_65:
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	add rax, rcx
	push rax
	mov rax, 1
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _calloc
	mov [rbp-24], rax
	mov rax, 0
	mov [rbp-32], rax
label_67:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-32]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_70
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_70:
	test rax, rax
	jz label_69
	mov rax, 34
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_69:
	cmp rax, 0
	je label_68
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	push rax
	mov rax, qword [rbp-32]
	imul rax, 1
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	lea rax, [rbp-32]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_67
label_68:
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	imul rax, 1
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	mov rax, 2
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	mov [rbp-40], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	add rsp, 48
	pop rbp
	add rsp, 16
	ret
_parse_character:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	mov rax, 2
	push rax
	mov rax, 1
	pop rcx
	mul rcx
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	movzx rax, byte [rbp-8]
	push rax
	mov rax, 0
	imul rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, 0
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], cl
	mov rax, 3
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
_parse_symbol:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	cmp rax, 33
	je switch_0_case_33
	cmp rax, 38
	je switch_0_case_38
	cmp rax, 40
	je switch_0_case_40
	cmp rax, 41
	je switch_0_case_41
	cmp rax, 42
	je switch_0_case_42
	cmp rax, 43
	je switch_0_case_43
	cmp rax, 44
	je switch_0_case_44
	cmp rax, 45
	je switch_0_case_45
	cmp rax, 46
	je switch_0_case_46
	cmp rax, 47
	je switch_0_case_47
	cmp rax, 58
	je switch_0_case_58
	cmp rax, 59
	je switch_0_case_59
	cmp rax, 60
	je switch_0_case_60
	cmp rax, 61
	je switch_0_case_61
	cmp rax, 62
	je switch_0_case_62
	cmp rax, 91
	je switch_0_case_91
	cmp rax, 93
	je switch_0_case_93
	cmp rax, 123
	je switch_0_case_123
	cmp rax, 124
	je switch_0_case_124
	cmp rax, 125
	je switch_0_case_125
	jmp switch_0_default
switch_0_case_33:
	mov rax, 61
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_72
	mov rax, 19
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_17
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_73
label_72:
	mov rax, 17
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_18
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_73:
	jmp label_71
switch_0_case_38:
	mov rax, 38
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_74
	mov rax, 13
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_19
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_75
label_74:
	mov rax, 11
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_20
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_75:
	jmp label_71
switch_0_case_40:
	mov rax, 30
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_21
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_41:
	mov rax, 31
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_22
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_42:
	mov rax, 9
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_23
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_43:
	mov rax, 43
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_76
	mov rax, 26
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_24
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_77
label_76:
	mov rax, 7
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_25
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_77:
	jmp label_71
switch_0_case_44:
	mov rax, 29
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_26
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_45:
	mov rax, 62
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_78
	mov rax, 24
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_27
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_79
label_78:
	mov rax, 45
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_80
	mov rax, 27
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_28
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_81
label_80:
	mov rax, 8
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_29
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_81:
label_79:
	jmp label_71
switch_0_case_46:
	mov rax, 25
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_30
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_47:
	mov rax, 10
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_31
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_58:
	mov rax, 28
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_32
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_59:
	mov rax, 6
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_33
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_60:
	mov rax, 61
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_82
	mov rax, 22
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_34
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_83
label_82:
	mov rax, 20
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_35
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_83:
	jmp label_71
switch_0_case_61:
	mov rax, 61
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_84
	mov rax, 16
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_36
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_85
label_84:
	mov rax, 15
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_37
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_85:
	jmp label_71
switch_0_case_62:
	mov rax, 61
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_86
	mov rax, 23
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_38
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_87
label_86:
	mov rax, 21
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_39
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_87:
	jmp label_71
switch_0_case_91:
	mov rax, 32
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_40
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_93:
	mov rax, 33
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_41
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_123:
	mov rax, 4
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_42
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_case_124:
	mov rax, 124
	push rax
	mov rax, 1
	imul rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_88
	mov rax, 14
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_43
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_89
label_88:
	mov rax, 12
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_44
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
label_89:
	jmp label_71
switch_0_case_125:
	mov rax, 5
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	mov rax, _string_45
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_71
switch_0_default:
	mov rax, 1
	push rax
	mov rax, 2
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _calloc
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	mov [rax], cl
	mov rax, 50
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
label_71:
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _token_new
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
_skip_whitespace:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
label_90:
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	pop rdi
	mov al, 0
	call _is_whitespace
	cmp rax, 0
	je label_91
	mov rax, qword [rbp+8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_90
label_91:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_next_token:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _skip_whitespace
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_92
	mov rax, 1
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
label_92:
	mov rax, 47
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jz label_94
	mov rax, 47
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_94:
	cmp rax, 0
	je label_93
	mov rax, 1
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
label_93:
	mov rax, 35
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_95
	mov rax, 1
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
label_95:
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	mov [rbp-8], rax
	movzx rax, byte [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_beginning_name_char
	cmp rax, 0
	je label_96
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_name
	jmp label_97
label_96:
	movzx rax, byte [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_number_char
	cmp rax, 0
	je label_98
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_number
	jmp label_99
label_98:
	mov rax, 34
	push rax
	movzx rax, byte [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_100
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_string
	jmp label_101
label_100:
	mov rax, 39
	push rax
	movzx rax, byte [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_102
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_character
	jmp label_103
label_102:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_symbol
label_103:
label_101:
label_99:
label_97:
	mov rax, 0
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_parse_line:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, 0
	mov [rbp-16], rax
	lea rax, [rbp-16]
	push rax
	lea rax, [rbp-8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _getline
	mov [rbp-24], rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, 1
	neg rax
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_104
	mov rax, 1
	neg rax
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
label_104:
	mov rax, qword [rbp-16]
	mov [rbp-32], rax
label_105:
	mov rax, qword [rbp+8]
	push rax
	lea rax, [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _next_token
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_106
	jmp label_105
label_106:
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, 0
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	mov rax, 0
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_7: db 115, 116, 114, 117, 99, 116, 0
	_string_32: db 58, 0
	_string_24: db 43, 43, 0
	_string_33: db 59, 0
	_string_9: db 116, 121, 112, 101, 100, 101, 102, 0
	_string_35: db 60, 0
	_string_40: db 91, 0
	_string_37: db 61, 0
	_string_39: db 62, 0
	_string_42: db 123, 0
	_string_41: db 93, 0
	_string_18: db 33, 0
	_string_2: db 105, 102, 0
	_string_44: db 124, 0
	_string_12: db 99, 97, 115, 101, 0
	_string_45: db 125, 0
	_string_1: db 105, 110, 116, 0
	_string_28: db 45, 45, 0
	_string_11: db 115, 119, 105, 116, 99, 104, 0
	_string_34: db 60, 61, 0
	_string_6: db 101, 108, 115, 101, 0
	_string_20: db 38, 0
	_string_19: db 38, 38, 0
	_string_16: db 101, 110, 117, 109, 0
	_string_10: db 102, 111, 114, 0
	_string_36: db 61, 61, 0
	_string_21: db 40, 0
	_string_8: db 115, 105, 122, 101, 111, 102, 0
	_string_22: db 41, 0
	_string_23: db 42, 0
	_string_5: db 118, 111, 105, 100, 0
	_string_4: db 114, 101, 116, 117, 114, 110, 0
	_string_38: db 62, 61, 0
	_string_25: db 43, 0
	_string_3: db 119, 104, 105, 108, 101, 0
	_string_26: db 44, 0
	_string_29: db 45, 0
	_string_13: db 100, 101, 102, 97, 117, 108, 116, 0
	_string_30: db 46, 0
	_string_17: db 33, 61, 0
	_string_31: db 47, 0
	_string_14: db 98, 114, 101, 97, 107, 0
	_string_43: db 124, 124, 0
	_string_27: db 45, 62, 0
	_string_15: db 99, 104, 97, 114, 0
global _parse_string_advance
extern _token_delete
global _skip_whitespace
global _parse_string
global _parse_number
global _inspect_for_keywords
extern _queue_length
global _parse_name
global _is_number_char
global _is_char_in_range
extern _queue_test
extern _getline
global _parse_symbol
extern _calloc
extern _printf
extern _queue_readonly
extern _queue_empty
extern _strncmp
extern _queue_new
extern _str_token_type
extern _exit
global _parse_line
extern _strcmp
global _is_name_char
global _is_beginning_name_char
extern _fopen
extern _free
extern _malloc
global _is_whitespace
extern _token_deq
extern _deq
extern _queue_free
extern _token_peek
extern _is_segment
global _next_token
global _parse_character
extern _peek
extern _token_enq
extern _enq
extern _token_new
