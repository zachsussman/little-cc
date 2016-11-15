default rel
section .text

_is_whitespace:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
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
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_is_beginning_name_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_is_number_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_is_name_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_inspect_for_keywords:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 31
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_7:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_number:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
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
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_name:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
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
	mov rax, _string_3
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
	mov rax, 35
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
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_24:
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
	je label_25
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 36
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
	jmp label_26
label_25:
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
	je label_27
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 37
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
	jmp label_28
label_27:
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
	je label_29
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 38
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
	jmp label_30
label_29:
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
	je label_31
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 39
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
	jmp label_32
label_31:
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
	je label_33
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 40
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
	jmp label_34
label_33:
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
	je label_35
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 41
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
	jmp label_36
label_35:
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
	je label_37
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 42
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
	jmp label_38
label_37:
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
	je label_39
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 43
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
	jmp label_40
label_39:
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
	je label_41
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 45
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
	jmp label_42
label_41:
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
	je label_43
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 46
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
	jmp label_44
label_43:
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
	je label_45
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 47
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
	jmp label_46
label_45:
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
	je label_47
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 48
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
	jmp label_48
label_47:
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
	je label_49
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
	jmp label_50
label_49:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_17
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_51
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 44
	push rax
	mov rax, _string_17
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
	jmp label_52
label_51:
	mov rax, qword [rbp-16]
	push rax
	mov rax, _string_18
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_53
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, qword [rbp+8]
	push rax
	mov rax, 50
	push rax
	mov rax, _string_18
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
	jmp label_54
label_53:
	mov rax, 0
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
label_54:
label_52:
label_50:
label_48:
label_46:
label_44:
label_42:
label_40:
label_38:
label_36:
label_34:
label_32:
label_30:
label_28:
label_26:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_string_advance:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
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
	je label_55
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
	je label_56
	mov rax, 10
	mov [rbp-8], al
	jmp label_57
label_56:
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
	je label_58
	mov rax, 9
	mov [rbp-8], al
	jmp label_59
label_58:
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
	je label_60
	mov rax, 0
	mov [rbp-8], al
	jmp label_61
label_60:
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	mov [rbp-8], al
label_61:
label_59:
label_57:
	jmp label_62
label_55:
	mov rax, qword [rbp+8]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	mov [rbp-8], al
label_62:
	mov rax, qword [rbp+8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	movzx rax, byte [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_string:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
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
label_63:
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
	jz label_65
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
label_65:
	cmp rax, 0
	je label_64
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	lea rax, [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _parse_string_advance
	jmp label_63
label_64:
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
label_66:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-32]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_69
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
label_69:
	test rax, rax
	jz label_68
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
label_68:
	cmp rax, 0
	je label_67
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
	jmp label_66
label_67:
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
	mov [rbp-32], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_character:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_symbol:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	cmp rax, 42
	je switch_0_case_0
	cmp rax, 47
	je switch_0_case_1
	cmp rax, 123
	je switch_0_case_2
	cmp rax, 125
	je switch_0_case_3
	cmp rax, 59
	je switch_0_case_4
	cmp rax, 46
	je switch_0_case_5
	cmp rax, 40
	je switch_0_case_6
	cmp rax, 41
	je switch_0_case_7
	cmp rax, 44
	je switch_0_case_8
	cmp rax, 91
	je switch_0_case_9
	cmp rax, 93
	je switch_0_case_10
	cmp rax, 58
	je switch_0_case_11
	cmp rax, 63
	je switch_0_case_12
	cmp rax, 43
	je switch_0_case_13
	cmp rax, 45
	je switch_0_case_14
	cmp rax, 38
	je switch_0_case_15
	cmp rax, 124
	je switch_0_case_16
	cmp rax, 61
	je switch_0_case_17
	cmp rax, 62
	je switch_0_case_18
	cmp rax, 60
	je switch_0_case_19
	cmp rax, 33
	je switch_0_case_20
	jmp switch_0_default
switch_0_case_0:
	mov rax, 9
	mov [rbp-8], rax
	mov rax, _string_19
	mov [rbp-16], rax
	jmp label_70
switch_0_case_1:
	mov rax, 10
	mov [rbp-8], rax
	mov rax, _string_20
	mov [rbp-16], rax
	jmp label_70
switch_0_case_2:
	mov rax, 4
	mov [rbp-8], rax
	mov rax, _string_21
	mov [rbp-16], rax
	jmp label_70
switch_0_case_3:
	mov rax, 5
	mov [rbp-8], rax
	mov rax, _string_22
	mov [rbp-16], rax
	jmp label_70
switch_0_case_4:
	mov rax, 6
	mov [rbp-8], rax
	mov rax, _string_23
	mov [rbp-16], rax
	jmp label_70
switch_0_case_5:
	mov rax, 25
	mov [rbp-8], rax
	mov rax, _string_24
	mov [rbp-16], rax
	jmp label_70
switch_0_case_6:
	mov rax, 31
	mov [rbp-8], rax
	mov rax, _string_25
	mov [rbp-16], rax
	jmp label_70
switch_0_case_7:
	mov rax, 32
	mov [rbp-8], rax
	mov rax, _string_26
	mov [rbp-16], rax
	jmp label_70
switch_0_case_8:
	mov rax, 30
	mov [rbp-8], rax
	mov rax, _string_27
	mov [rbp-16], rax
	jmp label_70
switch_0_case_9:
	mov rax, 33
	mov [rbp-8], rax
	mov rax, _string_28
	mov [rbp-16], rax
	jmp label_70
switch_0_case_10:
	mov rax, 34
	mov [rbp-8], rax
	mov rax, _string_29
	mov [rbp-16], rax
	jmp label_70
switch_0_case_11:
	mov rax, 28
	mov [rbp-8], rax
	mov rax, _string_30
	mov [rbp-16], rax
	jmp label_70
switch_0_case_12:
	mov rax, 29
	mov [rbp-8], rax
	mov rax, _string_31
	mov [rbp-16], rax
	jmp label_70
switch_0_case_13:
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
	je label_71
	mov rax, 26
	mov [rbp-8], rax
	mov rax, _string_32
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_72
label_71:
	mov rax, 7
	mov [rbp-8], rax
	mov rax, _string_33
	mov [rbp-16], rax
label_72:
	jmp label_70
switch_0_case_14:
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
	je label_73
	mov rax, 24
	mov [rbp-8], rax
	mov rax, _string_34
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_74
label_73:
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
	je label_75
	mov rax, 27
	mov [rbp-8], rax
	mov rax, _string_35
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_76
label_75:
	mov rax, 8
	mov [rbp-8], rax
	mov rax, _string_36
	mov [rbp-16], rax
label_76:
label_74:
	jmp label_70
switch_0_case_15:
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
	je label_77
	mov rax, 13
	mov [rbp-8], rax
	mov rax, _string_37
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_78
label_77:
	mov rax, 11
	mov [rbp-8], rax
	mov rax, _string_38
	mov [rbp-16], rax
label_78:
	jmp label_70
switch_0_case_16:
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
	je label_79
	mov rax, 14
	mov [rbp-8], rax
	mov rax, _string_39
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_80
label_79:
	mov rax, 12
	mov [rbp-8], rax
	mov rax, _string_40
	mov [rbp-16], rax
label_80:
	jmp label_70
switch_0_case_17:
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
	je label_81
	mov rax, 16
	mov [rbp-8], rax
	mov rax, _string_41
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_82
label_81:
	mov rax, 15
	mov [rbp-8], rax
	mov rax, _string_42
	mov [rbp-16], rax
label_82:
	jmp label_70
switch_0_case_18:
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
	je label_83
	mov rax, 23
	mov [rbp-8], rax
	mov rax, _string_43
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_84
label_83:
	mov rax, 21
	mov [rbp-8], rax
	mov rax, _string_44
	mov [rbp-16], rax
label_84:
	jmp label_70
switch_0_case_19:
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
	je label_85
	mov rax, 22
	mov [rbp-8], rax
	mov rax, _string_45
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_86
label_85:
	mov rax, 20
	mov [rbp-8], rax
	mov rax, _string_46
	mov [rbp-16], rax
label_86:
	jmp label_70
switch_0_case_20:
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
	je label_87
	mov rax, 19
	mov [rbp-8], rax
	mov rax, _string_47
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_88
label_87:
	mov rax, 17
	mov [rbp-8], rax
	mov rax, _string_48
	mov [rbp-16], rax
label_88:
	jmp label_70
switch_0_default:
	mov rax, 1
	push rax
	mov rax, 2
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _calloc
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	mov rax, [rax]
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	mov [rax], cl
	mov rax, 51
	mov [rbp-8], rax
label_70:
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_skip_whitespace:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
label_89:
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
	je label_90
	mov rax, qword [rbp+8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_89
label_90:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_next_token:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
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
	je label_91
	mov rax, 1
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_91:
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
	jz label_93
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
label_93:
	cmp rax, 0
	je label_92
	mov rax, 1
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_92:
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
	je label_94
	mov rax, 1
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_94:
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
	je label_95
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_name
	jmp label_96
label_95:
	movzx rax, byte [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_number_char
	cmp rax, 0
	je label_97
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_number
	jmp label_98
label_97:
	mov rax, 34
	push rax
	movzx rax, byte [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_99
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_string
	jmp label_100
label_99:
	mov rax, 39
	push rax
	movzx rax, byte [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_101
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_character
	jmp label_102
label_101:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_symbol
label_102:
label_100:
label_98:
label_96:
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_parse_line:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
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
	je label_103
	mov rax, 1
	neg rax
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_103:
	mov rax, qword [rbp-16]
	mov [rbp-32], rax
label_104:
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
	je label_105
	jmp label_104
label_105:
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _free
	mov rax, 0
	mov [rbp-32], rax
	mov rax, 0
	mov [rbp-16], rax
	mov rax, 0
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
	_string_32: db 43, 43, 0
	_string_30: db 58, 0
	_string_7: db 118, 111, 105, 100, 0
	_string_2: db 33, 113, 117, 101, 117, 101, 95, 101, 109, 112, 116, 121, 40, 81, 41, 0
	_string_23: db 59, 0
	_string_46: db 60, 0
	_string_1: db 116, 111, 107, 101, 110, 105, 122, 101, 114, 47, 116, 111, 107, 101, 110, 105, 122, 101, 46, 99, 0
	_string_42: db 61, 0
	_string_28: db 91, 0
	_string_44: db 62, 0
	_string_48: db 33, 0
	_string_31: db 63, 0
	_string_29: db 93, 0
	_string_21: db 123, 0
	_string_4: db 105, 102, 0
	_string_40: db 124, 0
	_string_22: db 125, 0
	_string_3: db 105, 110, 116, 0
	_string_35: db 45, 45, 0
	_string_45: db 60, 61, 0
	_string_38: db 38, 0
	_string_37: db 38, 38, 0
	_string_12: db 102, 111, 114, 0
	_string_41: db 61, 61, 0
	_string_25: db 40, 0
	_string_26: db 41, 0
	_string_15: db 100, 101, 102, 97, 117, 108, 116, 0
	_string_9: db 115, 116, 114, 117, 99, 116, 0
	_string_19: db 42, 0
	_string_17: db 99, 104, 97, 114, 0
	_string_43: db 62, 61, 0
	_string_33: db 43, 0
	_string_27: db 44, 0
	_string_36: db 45, 0
	_string_11: db 116, 121, 112, 101, 100, 101, 102, 0
	_string_47: db 33, 61, 0
	_string_24: db 46, 0
	_string_20: db 47, 0
	_string_5: db 119, 104, 105, 108, 101, 0
	_string_14: db 99, 97, 115, 101, 0
	_string_13: db 115, 119, 105, 116, 99, 104, 0
	_string_39: db 124, 124, 0
	_string_34: db 45, 62, 0
	_string_16: db 98, 114, 101, 97, 107, 0
	_string_8: db 101, 108, 115, 101, 0
	_string_10: db 115, 105, 122, 101, 111, 102, 0
	_string_18: db 101, 110, 117, 109, 0
	_string_6: db 114, 101, 116, 117, 114, 110, 0
extern _fprintf
extern _strdup
extern _my_assert
extern _strtol
extern _calloc
extern _malloc
global _is_name_char
global _is_number_char
extern _strncmp
global _parse_line
extern _queue_test
extern _fclose
extern _getline
extern _free
global _parse_string_advance
extern _strndup
global _next_token
global _is_char_in_range
extern _token_delete
global _is_whitespace
extern _queue_length
global _parse_symbol
global _parse_name
extern _token_peek
extern _peek
global _parse_number
extern _queue_free
global _parse_string
extern _queue_empty
global _skip_whitespace
global _parse_character
global _inspect_for_keywords
extern _token_deq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
extern _printf
global _is_beginning_name_char
extern _str_token_type
extern _strcmp
extern _token_enq
extern _enq
extern _token_new
extern _exit
