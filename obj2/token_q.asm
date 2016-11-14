default rel
section .text

_token_enq:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+8]
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
_token_deq:
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
	call _deq
	mov [rbp-8], rax
	mov rax, 1
	cmp rax, 0
	je label_1
	mov rax, _string_1
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
label_1:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_token_peek:
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
	call _peek
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
	_string_1: db 37, 115, 32, 0
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
extern _queue_length
global _token_peek
extern _peek
extern _queue_free
extern _queue_empty
global _token_deq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
extern _printf
extern _str_token_type
extern _strcmp
global _token_enq
extern _enq
extern _token_new
extern _exit
