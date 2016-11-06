default rel
section .text

_is_segment:
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
	cmp rax, 0
	je label_1
	mov rax, 0
	add rsp, 0
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
	add rsp, 0
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
extern _getline
extern _printf
extern _calloc
extern _strncmp
extern _exit
extern _strcmp
extern _fopen
extern _free
extern _malloc
global _is_segment
