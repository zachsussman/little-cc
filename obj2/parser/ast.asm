default rel
section .text

_is_node:
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
	mov rax, 36
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_2
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
label_2:
label_1:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_node_var:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 12
	push rax
	mov rax, _string_2
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 20
	push rax
	mov rax, _string_3
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
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
	mov rax, 21
	push rax
	mov rax, _string_4
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
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
	mov rax, 23
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_my_strtol:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 0
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
label_3:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	imul rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_4
	mov rax, 48
	push rax
	mov rax, qword [rbp-16]
	imul rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	sub rax, rcx
	push rax
	mov rax, 10
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	mul rcx
	pop rcx
	add rax, rcx
	mov [rbp-8], rax
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_3
label_4:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_node_int:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 36
	push rax
	mov rax, _string_6
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
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _my_strtol
	mov [rbp-8], rax
	mov rax, 0
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-24], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 2
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 48
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp-16]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_node_char:
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
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	movzx rax, byte [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 3
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 61
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_string:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 66
	push rax
	mov rax, _string_7
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 5
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 74
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_call:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 79
	push rax
	mov rax, _string_8
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, 80
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strndup
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov al, 0
	call _queue_new
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 4
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 88
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_node_call_enq:
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
	mov rax, _string_9
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 94
	push rax
	mov rax, _string_10
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 95
	push rax
	mov rax, _string_11
	push rax
	mov rax, 4
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
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_node_call_empty:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 103
	push rax
	mov rax, _string_9
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 104
	push rax
	mov rax, _string_11
	push rax
	mov rax, 4
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
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_node_call_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 112
	push rax
	mov rax, _string_9
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 113
	push rax
	mov rax, _string_11
	push rax
	mov rax, 4
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
	mov rax, _string_1
	push rax
	mov rax, 114
	push rax
	mov rax, _string_12
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _node_call_empty
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
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_node_sizeof:
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
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 7
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 129
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_cast:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 134
	push rax
	mov rax, _string_13
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 6
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 143
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_arrow:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 148
	push rax
	mov rax, _string_13
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 149
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 8
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 158
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_binop:
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
	mov rax, 164
	push rax
	mov rax, _string_15
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	mov rax, _string_16
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 174
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_node_ternary:
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
	mov rax, 180
	push rax
	mov rax, _string_15
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 181
	push rax
	mov rax, _string_17
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 182
	push rax
	mov rax, _string_16
	push rax
	mov rax, qword [rbp+32]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+32]
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 192
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_node_unop:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 197
	push rax
	mov rax, _string_13
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 205
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_declaration:
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
	mov rax, 210
	push rax
	mov rax, _string_2
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, 80
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strndup
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+32]
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 221
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_node_statement:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 226
	push rax
	mov rax, _string_18
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 31
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 234
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_if:
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
	mov rax, 239
	push rax
	mov rax, _string_19
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 240
	push rax
	mov rax, _string_20
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 32
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 250
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_node_while:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 255
	push rax
	mov rax, _string_19
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 256
	push rax
	mov rax, _string_20
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 33
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 265
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_for:
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
	mov rax, 270
	push rax
	mov rax, _string_21
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 271
	push rax
	mov rax, _string_19
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 272
	push rax
	mov rax, _string_22
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 273
	push rax
	mov rax, _string_20
	push rax
	mov rax, qword [rbp+32]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 40
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+32]
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
	mov rax, 35
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 284
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_node_break:
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
	mov rax, 36
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
	mov rax, _string_1
	push rax
	mov rax, 293
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_new_node_case:
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
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_node_switch:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 40
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, 0
	mov [rbp-24], rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _queue_readonly
	mov [rbp-32], rax
label_5:
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_6
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _deq
	lea rax, [rbp-24]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_5
label_6:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-24]
	push rax
	mov rax, 8
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _calloc
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _queue_readonly
	mov [rbp-32], rax
	mov rax, 0
	mov [rbp-40], rax
label_7:
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-40]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	test rax, rax
	jz label_9
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
label_9:
	cmp rax, 0
	je label_8
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _deq
	mov [rbp-48], rax
	mov rax, qword [rbp-48]
	push rax
	mov rax, qword [rbp-40]
	imul rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	lea rax, [rbp-40]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_7
label_8:
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 37
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 328
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
	add rsp, 32
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_new_node_sequence:
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov al, 0
	call _queue_new
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 38
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, _string_1
	push rax
	mov rax, 340
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
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
_sequence_empty:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 345
	push rax
	mov rax, _string_23
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 346
	push rax
	mov rax, _string_24
	push rax
	mov rax, 38
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
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_sequence_enq:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 354
	push rax
	mov rax, _string_23
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 355
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 356
	push rax
	mov rax, _string_24
	push rax
	mov rax, 38
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
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_sequence_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 364
	push rax
	mov rax, _string_23
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 365
	push rax
	mov rax, _string_24
	push rax
	mov rax, 38
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
	mov rax, _string_1
	push rax
	mov rax, 366
	push rax
	mov rax, _string_25
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _sequence_empty
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
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _deq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_sequence_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 374
	push rax
	mov rax, _string_23
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 375
	push rax
	mov rax, _string_24
	push rax
	mov rax, 38
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
	mov rax, _string_1
	push rax
	mov rax, 376
	push rax
	mov rax, _string_25
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _sequence_empty
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
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _peek
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_new_node_fn_arg:
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
_new_node_function:
	push rcx
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 48
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _strdup
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _queue_length
	push rax
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	mov rax, 8
	pop rcx
	mul rcx
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	mov rax, qword [rbp-16]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov [rbp-24], rax
label_10:
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_11
	mov rax, qword [rbp+24]
	push rax
	pop rdi
	mov al, 0
	call _deq
	push rax
	mov rax, qword [rbp-24]
	imul rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+24]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	lea rax, [rbp-24]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_10
label_11:
	mov rax, qword [rbp+32]
	push rax
	mov rax, qword [rbp-16]
	add rax, 32
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 39
	push rax
	mov rax, qword [rbp-8]
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
_new_node_struct:
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 41
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
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
_new_node_typedef:
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 42
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
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
_new_node_enum:
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov al, 0
	call _queue_new
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 43
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
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
_enum_add_val:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_print_binop_node:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_print_unop_node:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
__print_n_tabs:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 0
	mov [rbp-8], rax
label_12:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_13
	mov rax, _string_26
	push rax
	pop rdi
	mov al, 0
	call _printf
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_12
label_13:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
__print_node:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 463
	push rax
	mov rax, _string_5
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_node
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 464
	push rax
	mov rax, _string_27
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, 0
	pop rcx
	cmp rax, rcx
	setle al
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
	pop rdi
	mov al, 0
	call __print_n_tabs
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	cmp rax, 1
	je switch_0_case_0
	cmp rax, 2
	je switch_0_case_1
	cmp rax, 5
	je switch_0_case_2
	cmp rax, 4
	je switch_0_case_3
	cmp rax, 7
	je switch_0_case_4
	cmp rax, 6
	je switch_0_case_5
	cmp rax, 8
	je switch_0_case_6
	cmp rax, 9
	je switch_0_case_7
	cmp rax, 10
	je switch_0_case_8
	cmp rax, 11
	je switch_0_case_9
	cmp rax, 13
	je switch_0_case_10
	cmp rax, 14
	je switch_0_case_11
	cmp rax, 18
	je switch_0_case_12
	cmp rax, 19
	je switch_0_case_13
	cmp rax, 16
	je switch_0_case_14
	cmp rax, 17
	je switch_0_case_15
	cmp rax, 20
	je switch_0_case_16
	cmp rax, 21
	je switch_0_case_17
	cmp rax, 22
	je switch_0_case_18
	cmp rax, 23
	je switch_0_case_19
	cmp rax, 24
	je switch_0_case_20
	cmp rax, 25
	je switch_0_case_21
	cmp rax, 29
	je switch_0_case_22
	cmp rax, 30
	je switch_0_case_23
	cmp rax, 31
	je switch_0_case_24
	cmp rax, 32
	je switch_0_case_25
	cmp rax, 33
	je switch_0_case_26
	cmp rax, 35
	je switch_0_case_27
	cmp rax, 34
	je switch_0_case_28
	cmp rax, 38
	je switch_0_case_29
	cmp rax, 39
	je switch_0_case_30
	jmp switch_0_default
switch_0_case_0:
	mov rax, _string_28
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_14
switch_0_case_1:
	mov rax, _string_29
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_14
switch_0_case_2:
	mov rax, _string_30
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_14
switch_0_case_3:
	mov rax, _string_31
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_readonly
	mov [rbp-8], rax
label_15:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_16
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_15
label_16:
	jmp label_14
switch_0_case_4:
	mov rax, _string_32
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_33
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_14
switch_0_case_5:
	mov rax, _string_34
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_33
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_14
switch_0_case_6:
	mov rax, _string_35
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_14
switch_0_case_7:
	mov rax, _string_36
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_8:
	mov rax, _string_37
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_unop_node
	jmp label_14
switch_0_case_9:
	mov rax, _string_38
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_unop_node
	jmp label_14
switch_0_case_10:
	mov rax, _string_39
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_unop_node
	jmp label_14
switch_0_case_11:
	mov rax, _string_40
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_unop_node
	jmp label_14
switch_0_case_12:
	mov rax, _string_41
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_13:
	mov rax, _string_42
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_14:
	mov rax, _string_43
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_15:
	mov rax, _string_44
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_16:
	mov rax, _string_45
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_17:
	mov rax, _string_46
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_18:
	mov rax, _string_47
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_19:
	mov rax, _string_48
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_20:
	mov rax, _string_49
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_21:
	mov rax, _string_50
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_22:
	mov rax, _string_51
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_binop_node
	jmp label_14
switch_0_case_23:
	mov rax, _string_52
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_53
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+16]
	cmp rax, 0
	je label_17
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+16]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
label_17:
	jmp label_14
switch_0_case_24:
	mov rax, _string_54
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_14
switch_0_case_25:
	mov rax, _string_55
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_18
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
label_18:
	jmp label_14
switch_0_case_26:
	mov rax, _string_56
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_14
switch_0_case_27:
	mov rax, _string_57
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+16]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+24]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_14
switch_0_case_28:
	mov rax, _string_58
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _print_unop_node
	jmp label_14
switch_0_case_29:
	mov rax, _string_59
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _queue_readonly
	mov [rbp-8], rax
label_19:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_20
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	jmp label_19
label_20:
	jmp label_14
switch_0_case_30:
	mov rax, _string_60
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_53
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 0
	mov [rbp-16], rax
label_21:
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_22
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rdi
	mov al, 0
	call __print_n_tabs
	mov rax, _string_61
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
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
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_53
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
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_21
label_22:
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+32]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_23
	mov rax, qword [rbp-8]
	mov rax, [rax+32]
	push rax
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
label_23:
	jmp label_14
switch_0_default:
	mov rax, _string_62
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_14
label_14:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
__ast_construct_scope:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 96
	and rsp, -16
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_24
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_24:
	mov rax, 38
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_25
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _scope_new
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _queue_readonly
	mov [rbp-24], rax
label_26:
	mov rax, qword [rbp-24]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_27
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rdi
	mov al, 0
	call _deq
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	jmp label_26
label_27:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	jmp label_28
label_25:
	mov rax, 30
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_29
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
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
	call _scope_add_local
	jmp label_30
label_29:
	mov rax, 39
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_31
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+32]
	mov [rbp-16], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 40
	pop rcx
	mov [rax], rcx
	jmp label_32
label_31:
	mov rax, 32
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
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	jmp label_34
label_33:
	mov rax, 33
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_35
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	jmp label_36
label_35:
	mov rax, 35
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_37
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _scope_new
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 32
	pop rcx
	mov [rax], rcx
	jmp label_38
label_37:
	mov rax, 37
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_39
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _scope_new
	mov [rbp-8], rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, 0
	mov [rbp-24], rax
label_40:
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_41
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	imul rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_42
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-24]
	imul rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
label_42:
	lea rax, [rbp-24]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_40
label_41:
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 32
	pop rcx
	mov [rax], rcx
label_39:
label_38:
label_36:
label_34:
label_32:
label_30:
label_28:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_ast_construct_scope:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_construct_scope
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_print_node:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
	push rax
	mov rax, 0
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_39: db 65, 83, 84, 95, 65, 68, 68, 82, 69, 83, 83, 10, 0
	_string_47: db 65, 83, 84, 95, 71, 84, 10, 0
	_string_43: db 65, 83, 84, 95, 77, 85, 76, 84, 73, 80, 76, 73, 67, 65, 84, 73, 79, 78, 10, 0
	_string_40: db 65, 83, 84, 95, 68, 69, 82, 69, 70, 69, 82, 69, 78, 67, 69, 10, 0
	_string_36: db 65, 83, 84, 95, 65, 82, 82, 65, 89, 95, 83, 85, 66, 10, 0
	_string_29: db 65, 83, 84, 95, 73, 78, 84, 69, 71, 69, 82, 32, 37, 105, 10, 0
	_string_28: db 65, 83, 84, 95, 86, 65, 82, 73, 65, 66, 76, 69, 32, 37, 115, 10, 0
	_string_23: db 105, 115, 95, 110, 111, 100, 101, 40, 115, 101, 113, 41, 0
	_string_25: db 33, 115, 101, 113, 117, 101, 110, 99, 101, 95, 101, 109, 112, 116, 121, 40, 115, 101, 113, 41, 0
	_string_6: db 114, 101, 112, 114, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_60: db 65, 83, 84, 95, 70, 85, 78, 67, 84, 73, 79, 78, 58, 32, 0
	_string_49: db 65, 83, 84, 95, 69, 81, 10, 0
	_string_14: db 102, 105, 101, 108, 100, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_30: db 65, 83, 84, 95, 83, 84, 82, 73, 78, 71, 32, 34, 37, 115, 34, 10, 0
	_string_19: db 105, 115, 95, 110, 111, 100, 101, 40, 99, 111, 110, 100, 41, 0
	_string_5: db 105, 115, 95, 110, 111, 100, 101, 40, 110, 41, 0
	_string_8: db 102, 110, 95, 110, 97, 109, 101, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_57: db 65, 83, 84, 95, 70, 79, 82, 10, 0
	_string_55: db 65, 83, 84, 95, 73, 70, 10, 0
	_string_24: db 115, 101, 113, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 83, 69, 81, 85, 69, 78, 67, 69, 0
	_string_22: db 105, 115, 95, 110, 111, 100, 101, 40, 101, 110, 100, 41, 0
	_string_12: db 33, 110, 111, 100, 101, 95, 99, 97, 108, 108, 95, 101, 109, 112, 116, 121, 40, 99, 97, 108, 108, 41, 0
	_string_2: db 110, 97, 109, 101, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_52: db 65, 83, 84, 95, 76, 79, 67, 65, 76, 95, 68, 69, 67, 76, 65, 82, 65, 84, 73, 79, 78, 58, 32, 0
	_string_50: db 65, 83, 84, 95, 78, 69, 81, 10, 0
	_string_48: db 65, 83, 84, 95, 71, 84, 69, 10, 0
	_string_1: db 112, 97, 114, 115, 101, 114, 47, 97, 115, 116, 46, 99, 0
	_string_44: db 65, 83, 84, 95, 68, 73, 86, 73, 83, 73, 79, 78, 10, 0
	_string_10: db 105, 115, 95, 110, 111, 100, 101, 40, 97, 114, 103, 41, 0
	_string_4: db 101, 45, 62, 110, 97, 109, 101, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_62: db 65, 83, 84, 95, 85, 78, 75, 78, 79, 87, 78, 10, 0
	_string_26: db 9, 0
	_string_53: db 32, 37, 115, 10, 0
	_string_33: db 10, 0
	_string_58: db 65, 83, 84, 95, 82, 69, 84, 85, 82, 78, 10, 0
	_string_13: db 105, 115, 95, 110, 111, 100, 101, 40, 105, 110, 110, 101, 114, 41, 0
	_string_45: db 65, 83, 84, 95, 76, 84, 10, 0
	_string_59: db 65, 83, 84, 95, 83, 69, 81, 85, 69, 78, 67, 69, 10, 0
	_string_27: db 48, 32, 60, 61, 32, 100, 101, 112, 116, 104, 0
	_string_21: db 105, 115, 95, 110, 111, 100, 101, 40, 105, 110, 105, 116, 41, 0
	_string_20: db 105, 115, 95, 110, 111, 100, 101, 40, 98, 111, 100, 121, 41, 0
	_string_17: db 105, 115, 95, 110, 111, 100, 101, 40, 109, 105, 100, 100, 108, 101, 41, 0
	_string_7: db 115, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_41: db 65, 83, 84, 95, 65, 68, 68, 73, 84, 73, 79, 78, 10, 0
	_string_18: db 105, 115, 95, 110, 111, 100, 101, 40, 101, 120, 112, 114, 41, 0
	_string_15: db 105, 115, 95, 110, 111, 100, 101, 40, 108, 101, 102, 116, 41, 0
	_string_16: db 105, 115, 95, 110, 111, 100, 101, 40, 114, 105, 103, 104, 116, 41, 0
	_string_38: db 65, 83, 84, 95, 68, 69, 67, 82, 69, 77, 69, 78, 84, 10, 0
	_string_34: db 65, 83, 84, 95, 67, 65, 83, 84, 32, 0
	_string_31: db 65, 83, 84, 95, 70, 78, 95, 67, 65, 76, 76, 32, 37, 115, 10, 0
	_string_9: db 105, 115, 95, 110, 111, 100, 101, 40, 99, 97, 108, 108, 41, 0
	_string_56: db 65, 83, 84, 95, 87, 72, 73, 76, 69, 10, 0
	_string_46: db 65, 83, 84, 95, 76, 84, 69, 10, 0
	_string_3: db 101, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_42: db 65, 83, 84, 95, 83, 85, 66, 84, 82, 65, 67, 84, 73, 79, 78, 10, 0
	_string_11: db 99, 97, 108, 108, 45, 62, 116, 121, 112, 101, 32, 61, 61, 32, 65, 83, 84, 95, 70, 78, 95, 67, 65, 76, 76, 0
	_string_32: db 65, 83, 84, 95, 83, 73, 90, 69, 79, 70, 32, 0
	_string_61: db 65, 82, 71, 32, 37, 105, 58, 32, 0
	_string_54: db 65, 83, 84, 95, 83, 84, 65, 84, 69, 77, 69, 78, 84, 10, 0
	_string_51: db 65, 83, 84, 95, 65, 83, 83, 73, 71, 78, 10, 0
	_string_37: db 65, 83, 84, 95, 73, 78, 67, 82, 69, 77, 69, 78, 84, 10, 0
	_string_35: db 65, 83, 84, 95, 65, 82, 82, 79, 87, 32, 37, 115, 10, 0
global _new_node_typedef
global _new_node_struct
global _sequence_empty
extern _fprintf
global _new_node_char
extern _hash_insert
extern _strdup
global _is_node
global _new_node_sequence
global _new_node_string
extern _type_add_field
extern _hash_get
extern _my_assert
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
global __print_n_tabs
global _sequence_deq
extern _scope_add_local
extern _type_get_field
extern _queue_test
extern _fclose
extern _getline
extern _free
extern _type_new_pointer
global _new_node_call
extern _type_new_fn
extern _strndup
global _new_node_statement
global _new_node_cast
extern _hash_new
extern _token_delete
global _new_node_switch
global _new_node_binop
global __print_node
global _sequence_peek
global _ast_construct_scope
global _enum_add_val
global _new_node_for
extern _queue_length
global _new_node_sizeof
global _print_binop_node
global _new_node_fn_arg
global _new_node_break
global _new_node_ternary
global _new_node_arrow
global _new_node_int
extern _scope_new
extern _peek
global __ast_construct_scope
global _print_unop_node
global _print_node
extern _type_print
extern _types_init
extern _hash_in
extern _queue_free
global _my_strtol
global _new_node_enum
extern _type_pointer_inner
global _new_node_while
extern _is_scope
extern _queue_empty
global _new_node_unop
extern _type_new_base
extern _hash_do_over
global _new_node_function
global _new_node_case
global _node_call_enq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
global _new_node_if
extern _printf
extern _scope_find_local
extern _type_new_undet
extern _type_new_undet_struct
global _new_node_declaration
extern _str_token_type
global _node_call_empty
global _new_node_var
extern _type_new_struct
extern _strcmp
global _sequence_enq
global _node_call_deq
extern _enq
extern _token_new
extern _exit
