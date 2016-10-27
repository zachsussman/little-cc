default rel
extern _exit
extern _printf
section .text
global _main
_main:
	push rbx
	mov rax, 10
	mov [g3], rax
	mov rax, 0
	mov [g0], rax
	mov rax, 1
	mov [g1], rax
label_0:
	mov rax, 0
	push rax
	mov rax, qword [g3]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	cmp rax, 0
	je label_1
	push rbx
	mov rax, qword [g1]
	mov [g2], rax
	mov rax, qword [g0]
	push rax
	mov rax, qword [g1]
	pop rcx
	add rax, rcx
	mov [g1], rax
	mov rax, qword [g2]
	mov [g0], rax
	mov rax, 1
	push rax
	mov rax, qword [g3]
	pop rcx
	sub rax, rcx
	mov [g3], rax
	pop rbx
	jmp label_0
label_1:
	mov rax, _string_0
	mov rdi, rax
	mov rax, qword [g1]
	mov rsi, rax
	mov al, 0
	call _printf
	pop rbx
	mov rdi, rax
	mov rax, 0x2000001
	syscall
	
section .data
	dummy: dw 16
	g0: dq 0
	g1: dq 0
	g2: dq 0
	g3: dq 0
	_string_0: db 84, 104, 101, 32, 49, 48, 116, 104, 32, 102, 105, 98, 111, 110, 97, 99, 99, 105, 32, 110, 117, 109, 98, 101, 114, 32, 105, 115, 58, 32, 37, 105, 10, 0
