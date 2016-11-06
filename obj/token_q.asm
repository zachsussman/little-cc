default rel
section .text

_token_enq:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, qword [rbp+8]
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
_token_deq:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
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
	mov rax, qword [rbp-8]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
label_1:
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_token_peek:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _peek
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_1: db 37, 115, 32, 0
extern _token_delete
extern _queue_length
extern _queue_test
extern _getline
extern _printf
extern _queue_readonly
extern _calloc
extern _queue_empty
extern _strncmp
extern _queue_new
extern _str_token_type
extern _exit
extern _strcmp
extern _fopen
extern _free
extern _malloc
global _token_deq
extern _deq
extern _queue_free
extern _is_segment
global _token_peek
extern _peek
global _token_enq
extern _enq
extern _token_new
