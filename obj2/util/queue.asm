default rel
section .text

_is_segment_q:
	push rsi
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
	mov rsp, rbp
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
	mov rsp, rbp
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_5:
label_3:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_is_queue:
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_queue_new:
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
	mov rax, _string_1
	push rax
	mov rax, 23
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
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
_queue_empty:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 28
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_enq:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 34
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
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
	mov rax, _string_1
	push rax
	mov rax, 39
	push rax
	mov rax, _string_3
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
	mov rax, _string_1
	push rax
	mov rax, 45
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
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
_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 49
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 50
	push rax
	mov rax, _string_4
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
	mov rax, [rax+0]
	mov rax, [rax+0]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 56
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, _string_1
	push rax
	mov rax, 57
	push rax
	mov rax, _string_4
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
	mov rax, _string_1
	push rax
	mov rax, 62
	push rax
	mov rax, _string_2
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_queue
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
_queue_readonly:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 67
	push rax
	mov rax, _string_5
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_queue_length:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
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
	mov [rbp-8], rax
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_7
label_8:
	mov rax, qword [rbp-16]
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
	_string_4: db 33, 113, 117, 101, 117, 101, 95, 101, 109, 112, 116, 121, 40, 81, 41, 0
	_string_2: db 105, 115, 95, 113, 117, 101, 117, 101, 40, 81, 41, 0
	_string_3: db 108, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_1: db 117, 116, 105, 108, 47, 113, 117, 101, 117, 101, 46, 99, 0
	_string_5: db 81, 32, 33, 61, 32, 78, 85, 76, 76, 0
extern _fprintf
extern _strdup
extern _my_assert
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
extern _queue_test
extern _fclose
extern _getline
extern _free
extern _strndup
extern _token_delete
global _queue_length
global _peek
global _is_segment_q
extern _queue_free
global _queue_empty
global _queue_readonly
global _deq
global _queue_new
extern _is_segment
extern _fopen
extern _printf
extern _str_token_type
extern _strcmp
global _is_queue
global _enq
extern _token_new
extern _exit
