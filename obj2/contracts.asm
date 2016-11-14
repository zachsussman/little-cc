default rel
section .text

_my_assert:
	push rcx
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 0
	and rsp, -16
	mov rax, qword [rbp+32]
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_1
	mov rax, _string_1
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+24]
	push rax
	pop rcx
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
label_1:
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
	
section .data
	dummy: dw 16
	_string_1: db 37, 115, 58, 37, 100, 32, 97, 115, 115, 101, 114, 116, 105, 111, 110, 32, 102, 97, 105, 108, 101, 100, 58, 32, 37, 115, 10, 0
extern _fprintf
extern _strdup
global _my_assert
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
extern _fclose
extern _getline
extern _free
extern _strndup
extern _fopen
extern _printf
extern _strcmp
extern _exit
