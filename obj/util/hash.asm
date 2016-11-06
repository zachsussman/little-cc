default rel
section .text

_hash_str:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 5381
	mov [rbp-8], rax
label_1:
	lea rax, [rbp+8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	cmp rax, 0
	je label_2
	mov rax, qword [rbp-16]
	push rax
	mov rax, 33
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	mul rcx
	pop rcx
	add rax, rcx
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
	jmp label_1
label_2:
	mov rax, qword [rbp-8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_key_index:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, qword [rbp+16]
	push rax
	pop rdi
	mov al, 0
	call _hash_str
	mov [rbp-8], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_3
	mov rax, qword [rbp-8]
	neg rax
	push rax
	lea rax, [rbp-8]
	pop rcx
	mov [rax], rcx
label_3:
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cqo
	div rcx
	pop rcx
	mul rcx
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	sub rax, rcx
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_are_chains_valid:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, 0
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
label_4:
	mov rax, qword [rbp+8]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_5
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-24], rax
label_6:
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_7
	mov rax, qword [rbp-16]
	push rax
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _key_index
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_8
	mov rax, 0
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
label_8:
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	lea rax, [rbp-8]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_6
label_7:
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_4
label_5:
	mov rax, qword [rbp+8]
	mov rax, [rax+0]
	push rax
	mov rax, qword [rbp-8]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
	add rsp, 32
	pop rbp
	add rsp, 16
	ret
_is_hash:
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
	jz label_9
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _are_chains_valid
label_9:
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
	add rsp, 0
	pop rbp
	add rsp, 16
	ret
_hash_new:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, 0
	mov rax, 0
	push rax
	mov rax, qword [rbp-8]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-8]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 8
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	mul rcx
	push rax
	pop rdi
	mov al, 0
	call _malloc
	push rax
	mov rax, qword [rbp-8]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov [rbp-16], rax
label_10:
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setl al
	movzx rax, al
	cmp rax, 0
	je label_11
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	imul rax, 8
	push rax
	mov rax, qword [rbp-8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	lea rax, [rbp-16]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_10
label_11:
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
_hash_insert:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _key_index
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	imul rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-24], rax
label_12:
	mov rax, 0
	push rax
	mov rax, qword [rbp-24]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_13
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-24]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_14
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 0
	add rsp, 32
	pop rbp
	add rsp, 32
	ret
label_14:
	mov rax, qword [rbp-24]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_12
label_13:
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-24], rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-24]
	add rax, 0
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-24]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-8]
	imul rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	push rax
	mov rax, qword [rbp-24]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-24]
	push rax
	mov rax, qword [rbp-8]
	imul rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp+8]
	add rax, 0
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	mov rax, 0
	add rsp, 32
	pop rbp
	add rsp, 32
	ret
_hash_in:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _key_index
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	imul rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-16], rax
label_15:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_16
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_17
	mov rax, 0
	mov rax, 1
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
label_17:
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_15
label_16:
	mov rax, 0
	mov rax, 0
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
_hash_get:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, 0
	mov rax, qword [rbp+8]
	push rax
	mov rax, qword [rbp+16]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _key_index
	mov [rbp-8], rax
	mov rax, qword [rbp-8]
	imul rax, 8
	push rax
	mov rax, qword [rbp+8]
	mov rax, [rax+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-16], rax
label_18:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_19
	mov rax, 0
	push rax
	mov rax, qword [rbp+16]
	push rax
	mov rax, qword [rbp-16]
	mov rax, [rax+0]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _strcmp
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_20
	mov rax, 0
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	add rsp, 16
	pop rbp
	add rsp, 16
	ret
label_20:
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_18
label_19:
	mov rax, 0
	mov rax, 0
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
global _hash_in
extern _getline
extern _printf
global _hash_insert
extern _calloc
extern _strncmp
extern _exit
extern _strcmp
global _are_chains_valid
extern _fopen
extern _free
extern _malloc
global _hash_new
global _key_index
extern _hash_do_over
global _hash_str
global _is_hash
global _hash_get
