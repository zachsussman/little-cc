default rel
section .text

_is_segment_q:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	test rax, rax
	jnz label_2
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
label_2:
	cmp rax, 0
	je label_1
	mov rax, 0
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_3
label_1:
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_4
	mov rax, 1
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	jmp label_5
label_4:
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _is_segment_q
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
label_5:
label_3:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_is_queue:
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
	jz label_6
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _is_segment_q
label_6:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_queue_new:
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
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
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
_queue_empty:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_enq:
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
	mov rax, 0
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp+8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 0
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+0]
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 0
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+0]
	mov [rbp-8], rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+8]
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
_queue_readonly:
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
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
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
_queue_length:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
label_7:
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_8
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_7
label_8:
	mov rax, qword [rbp-16]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
extern _token_delete
global _queue_length
extern _queue_test
extern _getline
extern _printf
global _queue_readonly
extern _calloc
global _queue_empty
extern _strncmp
global _queue_new
extern _str_token_type
extern _exit
extern _strcmp
extern _fopen
extern _free
extern _malloc
global _deq
global _is_segment_q
extern _queue_free
extern _is_segment
global _peek
global _is_queue
global _enq
extern _token_new
