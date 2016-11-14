default rel
section .text

_is_segment:
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
	cmp rax, 0
	je label_1
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_1:
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_2
	mov rax, 1
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
label_2:
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _is_segment
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
extern _fprintf
extern _strdup
extern _my_assert
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
extern _fclose
extern _getline
extern _free
extern _strndup
global _is_segment
extern _fopen
extern _printf
extern _strcmp
extern _exit
