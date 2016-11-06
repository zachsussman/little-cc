default rel
section .text

_is_node:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	test rax, rax
	jz label_1
	mov rax, 35
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
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_new_node_var:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_int:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	lea rax, [rbp-8]
	push rax
	mov rax, 10
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _strtol
	mov [rbp-16], rax
	mov rax, 0
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-24], rax
	mov rax, 8
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-32], rax
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp-32]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-32]
	push rax
	mov rax, qword [rbp-24]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 2
	push rax
	mov rax, qword [rbp-24]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-24]
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
_new_node_char:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_string:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_call:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_node_call_enq:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, 0
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
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_node_call_empty:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_node_call_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_sizeof:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_cast:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_arrow:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
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
	mov rax, 0
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
_new_node_unop:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
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
	mov rax, 0
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
_new_node_statement:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
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
	mov rax, 30
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
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
	mov rax, 0
	mov rax, 0
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
	mov rax, 31
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
_new_node_while:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
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
	mov rax, 32
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
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
	mov rax, 0
	mov rax, 0
	mov rax, 0
	mov rax, 0
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 32
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
	mov rax, 34
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
	add rsp, 16
	pop rbp
	add rsp, 32
	ret
_new_node_break:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 35
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 0
	ret
	add rsp, 16
	pop rbp
	add rsp, 0
	ret
_new_node_case:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
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
	mov rax, 16
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 32
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
label_3:
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_4
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _deq
	mov [rbp-40], rax
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-40]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	cmp rax, 0
	je label_5
	mov rax, qword [rbp-40]
	mov rax, [rax+0]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
label_5:
	jmp label_3
label_4:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	add rax, rcx
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
	push rax
	lea rax, [rbp-32]
	pop rcx
	mov [rax], rcx
label_6:
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_7
	mov rax, qword [rbp-32]
	push rax
	pop rdi
	mov al, 0
	call _deq
	mov [rbp-48], rax
	mov rax, qword [rbp-48]
	push rax
	mov rax, qword [rbp-48]
	mov rax, [rax+0]
	imul rax, 8
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	jmp label_6
label_7:
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 24
	pop rcx
	mov [rax], rcx
	mov rax, 1
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	add rax, rcx
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 36
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
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 48
	pop rbp
	add rsp, 32
	ret
	add rsp, 48
	pop rbp
	add rsp, 32
	ret
_new_node_sequence:
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, 37
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 0
	ret
	add rsp, 16
	pop rbp
	add rsp, 0
	ret
_sequence_empty:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_sequence_enq:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, 0
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
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_sequence_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _deq
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_sequence_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _peek
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_fn_arg:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
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
label_8:
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_9
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
	jmp label_8
label_9:
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
	mov rax, 38
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	add rsp, 32
	pop rbp
	add rsp, 32
	ret
	add rsp, 32
	pop rbp
	add rsp, 32
	ret
_new_node_struct:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, 40
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_typedef:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, 41
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_new_node_enum:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, 42
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_enum_add_val:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
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
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_print_binop_node:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_print_unop_node:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
__print_n_tabs:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov [rbp-8], rax
label_10:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_11
	mov rax, _string_1
	push rax
	pop rdi
	mov al, 0
	call _printf
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_10
label_11:
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
__print_node:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call __print_n_tabs
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	cmp rax, 1
	je switch_0_case_1
	cmp rax, 2
	je switch_0_case_2
	cmp rax, 4
	je switch_0_case_4
	cmp rax, 5
	je switch_0_case_5
	cmp rax, 6
	je switch_0_case_6
	cmp rax, 7
	je switch_0_case_7
	cmp rax, 8
	je switch_0_case_8
	cmp rax, 9
	je switch_0_case_9
	cmp rax, 10
	je switch_0_case_10
	cmp rax, 11
	je switch_0_case_11
	cmp rax, 13
	je switch_0_case_13
	cmp rax, 14
	je switch_0_case_14
	cmp rax, 16
	je switch_0_case_16
	cmp rax, 17
	je switch_0_case_17
	cmp rax, 18
	je switch_0_case_18
	cmp rax, 19
	je switch_0_case_19
	cmp rax, 20
	je switch_0_case_20
	cmp rax, 21
	je switch_0_case_21
	cmp rax, 22
	je switch_0_case_22
	cmp rax, 23
	je switch_0_case_23
	cmp rax, 24
	je switch_0_case_24
	cmp rax, 25
	je switch_0_case_25
	cmp rax, 28
	je switch_0_case_28
	cmp rax, 29
	je switch_0_case_29
	cmp rax, 30
	je switch_0_case_30
	cmp rax, 31
	je switch_0_case_31
	cmp rax, 32
	je switch_0_case_32
	cmp rax, 33
	je switch_0_case_33
	cmp rax, 34
	je switch_0_case_34
	cmp rax, 37
	je switch_0_case_37
	cmp rax, 38
	je switch_0_case_38
	jmp switch_0_default
switch_0_case_1:
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_12
switch_0_case_2:
	mov rax, _string_3
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_12
switch_0_case_4:
	mov rax, _string_4
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
label_13:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_14
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
	jmp label_13
label_14:
	jmp label_12
switch_0_case_5:
	mov rax, _string_5
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_12
switch_0_case_6:
	mov rax, _string_6
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
	mov rax, _string_7
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
	jmp label_12
switch_0_case_7:
	mov rax, _string_8
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
	mov rax, _string_7
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_12
switch_0_case_8:
	mov rax, _string_9
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
	jmp label_12
switch_0_case_9:
	mov rax, _string_10
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
	jmp label_12
switch_0_case_10:
	mov rax, _string_11
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
	jmp label_12
switch_0_case_11:
	mov rax, _string_12
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
	jmp label_12
switch_0_case_13:
	mov rax, _string_13
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
	jmp label_12
switch_0_case_14:
	mov rax, _string_14
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
	jmp label_12
switch_0_case_16:
	mov rax, _string_15
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
	jmp label_12
switch_0_case_17:
	mov rax, _string_16
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
	jmp label_12
switch_0_case_18:
	mov rax, _string_17
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
	jmp label_12
switch_0_case_19:
	mov rax, _string_18
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
	jmp label_12
switch_0_case_20:
	mov rax, _string_19
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
	jmp label_12
switch_0_case_21:
	mov rax, _string_20
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
	jmp label_12
switch_0_case_22:
	mov rax, _string_21
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
	jmp label_12
switch_0_case_23:
	mov rax, _string_22
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
	jmp label_12
switch_0_case_24:
	mov rax, _string_23
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
	jmp label_12
switch_0_case_25:
	mov rax, _string_24
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
	jmp label_12
switch_0_case_28:
	mov rax, _string_25
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
	jmp label_12
switch_0_case_29:
	mov rax, _string_26
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
	mov rax, _string_27
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
	je label_15
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
label_15:
	jmp label_12
switch_0_case_30:
	mov rax, _string_28
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
	jmp label_12
switch_0_case_31:
	mov rax, _string_29
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
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
	mov rax, qword [rbp-16]
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
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_16
	mov rax, qword [rbp-16]
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
label_16:
	jmp label_12
switch_0_case_32:
	mov rax, _string_30
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
	jmp label_12
switch_0_case_33:
	mov rax, _string_31
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
	jmp label_12
switch_0_case_34:
	mov rax, _string_32
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
	jmp label_12
switch_0_case_37:
	mov rax, _string_33
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
	mov [rbp-24], rax
label_17:
	mov rax, qword [rbp-24]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_18
	mov rax, qword [rbp-24]
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
	jmp label_17
label_18:
	jmp label_12
switch_0_case_38:
	mov rax, _string_34
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	mov [rbp-32], rax
	mov rax, qword [rbp-32]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_27
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 0
	mov [rbp-40], rax
label_19:
	mov rax, qword [rbp-32]
	mov rax, [rax+16]
	push rax
	mov rax, qword [rbp-40]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_20
	mov rax, 1
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	push rax
	pop rdi
	mov al, 0
	call __print_n_tabs
	mov rax, _string_35
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, qword [rbp-40]
	imul rax, 8
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+24]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _type_print
	mov rax, _string_27
	push rax
	mov rax, qword [rbp-40]
	imul rax, 8
	push rax
	mov rax, qword [rbp-32]
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
	lea rax, [rbp-40]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_19
label_20:
	mov rax, 0
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+32]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_21
	mov rax, qword [rbp-32]
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
label_21:
	jmp label_12
switch_0_default:
	mov rax, _string_36
	push rax
	pop rdi
	mov al, 0
	call _printf
	jmp label_12
label_12:
	add rsp, 48
	pop rbp
	add rsp, 16
	ret
__ast_locals:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 64
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_22
	mov rax, 0
	add rsp, 64
	pop rbp
	add rsp, 16
	ret
label_22:
	mov rax, 37
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_23
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+0]
	push rax
	pop rdi
	mov al, 0
	call _queue_readonly
	mov [rbp-8], rax
label_24:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_25
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _deq
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	jmp label_24
label_25:
	jmp label_26
label_23:
	mov rax, 29
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_27
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _enq
	jmp label_28
label_27:
	mov rax, 38
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
	mov [rbp-16], rax
	mov rax, qword [rbp-16]
	mov rax, [rax+32]
	mov [rbp-24], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	jmp label_30
label_29:
	mov rax, 31
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
	mov [rbp-32], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-32]
	mov rax, [rax+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
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
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	jmp label_34
label_33:
	mov rax, 34
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_35
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-40], rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-40]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-40]
	mov rax, [rax+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	jmp label_36
label_35:
	mov rax, 36
	push rax
	mov rax, qword [rbp+16]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_37
	mov rax, qword [rbp+16]
	mov rax, [rax+8]
	mov [rbp-48], rax
	mov rax, 0
	mov [rbp-56], rax
label_38:
	mov rax, qword [rbp-48]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-56]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_39
	mov rax, 0
	push rax
	mov rax, qword [rbp-56]
	imul rax, 8
	push rax
	mov rax, qword [rbp-48]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_40
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-56]
	imul rax, 8
	push rax
	mov rax, qword [rbp-48]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
label_40:
	lea rax, [rbp-56]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_38
label_39:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-48]
	mov rax, [rax+24]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
label_37:
label_36:
label_34:
label_32:
label_30:
label_28:
label_26:
	add rsp, 64
	pop rbp
	add rsp, 16
	ret
_ast_locals:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov al, 0
	call _queue_new
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __ast_locals
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_print_node:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, 0
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call __print_node
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_21: db 65, 83, 84, 95, 71, 84, 10, 0
	_string_33: db 65, 83, 84, 95, 83, 69, 81, 85, 69, 78, 67, 69, 10, 0
	_string_23: db 65, 83, 84, 95, 69, 81, 10, 0
	_string_8: db 65, 83, 84, 95, 83, 73, 90, 69, 79, 70, 32, 0
	_string_29: db 65, 83, 84, 95, 73, 70, 10, 0
	_string_11: db 65, 83, 84, 95, 73, 78, 67, 82, 69, 77, 69, 78, 84, 10, 0
	_string_34: db 65, 83, 84, 95, 70, 85, 78, 67, 84, 73, 79, 78, 58, 32, 0
	_string_3: db 65, 83, 84, 95, 73, 78, 84, 69, 71, 69, 82, 32, 37, 105, 10, 0
	_string_32: db 65, 83, 84, 95, 70, 79, 82, 10, 0
	_string_16: db 65, 83, 84, 95, 68, 73, 86, 73, 83, 73, 79, 78, 10, 0
	_string_9: db 65, 83, 84, 95, 65, 82, 82, 79, 87, 32, 37, 115, 10, 0
	_string_14: db 65, 83, 84, 95, 68, 69, 82, 69, 70, 69, 82, 69, 78, 67, 69, 10, 0
	_string_1: db 9, 0
	_string_7: db 10, 0
	_string_6: db 65, 83, 84, 95, 67, 65, 83, 84, 32, 0
	_string_24: db 65, 83, 84, 95, 78, 69, 81, 10, 0
	_string_22: db 65, 83, 84, 95, 71, 84, 69, 10, 0
	_string_26: db 65, 83, 84, 95, 76, 79, 67, 65, 76, 95, 68, 69, 67, 76, 65, 82, 65, 84, 73, 79, 78, 58, 32, 0
	_string_19: db 65, 83, 84, 95, 76, 84, 10, 0
	_string_15: db 65, 83, 84, 95, 77, 85, 76, 84, 73, 80, 76, 73, 67, 65, 84, 73, 79, 78, 10, 0
	_string_28: db 65, 83, 84, 95, 83, 84, 65, 84, 69, 77, 69, 78, 84, 10, 0
	_string_13: db 65, 83, 84, 95, 65, 68, 68, 82, 69, 83, 83, 10, 0
	_string_2: db 65, 83, 84, 95, 86, 65, 82, 73, 65, 66, 76, 69, 32, 37, 115, 10, 0
	_string_36: db 65, 83, 84, 95, 85, 78, 75, 78, 79, 87, 78, 10, 0
	_string_18: db 65, 83, 84, 95, 83, 85, 66, 84, 82, 65, 67, 84, 73, 79, 78, 10, 0
	_string_10: db 65, 83, 84, 95, 65, 82, 82, 65, 89, 95, 83, 85, 66, 10, 0
	_string_31: db 65, 83, 84, 95, 82, 69, 84, 85, 82, 78, 10, 0
	_string_12: db 65, 83, 84, 95, 68, 69, 67, 82, 69, 77, 69, 78, 84, 10, 0
	_string_5: db 65, 83, 84, 95, 83, 84, 82, 73, 78, 71, 32, 34, 37, 115, 34, 10, 0
	_string_35: db 65, 82, 71, 32, 37, 105, 58, 32, 0
	_string_27: db 32, 37, 115, 10, 0
	_string_4: db 65, 83, 84, 95, 70, 78, 95, 67, 65, 76, 76, 32, 37, 115, 10, 0
	_string_17: db 65, 83, 84, 95, 65, 68, 68, 73, 84, 73, 79, 78, 10, 0
	_string_30: db 65, 83, 84, 95, 87, 72, 73, 76, 69, 10, 0
	_string_25: db 65, 83, 84, 95, 65, 83, 83, 73, 71, 78, 10, 0
	_string_20: db 65, 83, 84, 95, 76, 84, 69, 10, 0
global _sequence_empty
extern _token_delete
global _new_node_call
global _new_node_cast
global _new_node_switch
extern _type_new_undet_struct
extern _type_new_fn
extern _hash_in
extern _queue_length
extern _type_add_field
extern _type_new_struct
extern _queue_test
extern _getline
global _enum_add_val
global _new_node_if
global _new_node_function
global _new_node_binop
global _new_node_string
global _new_node_var
extern _printf
extern _hash_insert
extern _queue_readonly
extern _calloc
global _new_node_enum
global _new_node_struct
extern _queue_empty
extern _strncmp
extern _queue_new
extern _str_token_type
extern _exit
global _new_node_break
global _new_node_arrow
extern _strcmp
global _new_node_unop
extern _type_new_undet
global __print_node
global _new_node_case
extern _type_print
extern _types_init
global _new_node_fn_arg
global _print_node
global _sequence_deq
extern _fopen
extern _free
extern _malloc
global _print_binop_node
global _new_node_while
extern _hash_new
global __ast_locals
global _new_node_declaration
global _new_node_for
global _new_node_statement
extern _type_pointer_inner
extern _type_new_pointer
extern _type_new_base
global _node_call_deq
extern _deq
global _node_call_empty
extern _hash_do_over
global __print_n_tabs
global _sequence_enq
global _new_node_char
extern _hash_str
extern _queue_free
extern _is_segment
global _sequence_peek
global _is_node
global _ast_locals
global _new_node_sequence
global _new_node_int
extern _hash_get
extern _type_get_field
global _print_unop_node
global _new_node_typedef
extern _peek
global _new_node_sizeof
global _node_call_enq
extern _enq
extern _token_new
