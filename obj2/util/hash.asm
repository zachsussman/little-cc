default rel
section .text

_hash_str:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, 5381
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-24], rax
	mov rax, 0
	mov [rbp-32], rax
label_1:
	mov rax, 0
	push rax
	mov rax, qword [rbp-32]
	imul rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	pop rcx
	cmp rax, rcx
	setne al
	movzx rax, al
	cmp rax, 0
	je label_2
	mov rax, qword [rbp-32]
	imul rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	add rax, rcx
	xor rcx, rcx
	mov cl, [rax]
	mov rax, rcx
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
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
	lea rax, [rbp-32]
	mov rcx, [rax]
	add qword [rax], 1
	mov rax, rcx
	jmp label_1
label_2:
	mov rax, qword [rbp-8]
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_key_index:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 21
	push rax
	mov rax, _string_2
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_are_chains_valid:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
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
	mov rsp, rbp
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
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_is_hash:
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
	jz label_9
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _are_chains_valid
label_9:
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_hash_new:
	sub rsp, 8
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 49
	push rax
	mov rax, _string_3
	push rax
	mov rax, 0
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 24
	push rax
	pop rdi
	mov al, 0
	call _malloc
	mov [rbp-8], rax
	mov rax, _string_1
	push rax
	mov rax, 53
	push rax
	mov rax, _string_2
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
	mov rax, _string_1
	push rax
	mov rax, 58
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
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
_hash_insert:
	sub rsp, 8
	push rdx
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 32
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 63
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
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
label_12:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
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
	je label_14
	mov rax, qword [rbp+24]
	push rax
	mov rax, qword [rbp-16]
	add rax, 8
	pop rcx
	mov [rax], rcx
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
label_14:
	mov rax, qword [rbp-16]
	mov rax, [rax+16]
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_12
label_13:
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
	mov rax, qword [rbp-16]
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
	mov rax, qword [rbp-16]
	add rax, 16
	pop rcx
	mov [rax], rcx
	mov rax, qword [rbp-16]
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
	mov rax, _string_1
	push rax
	mov rax, 81
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rsp, rbp
	pop rbp
	add rsp, 32
	ret
_hash_in:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 85
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
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
	mov rax, _string_1
	push rax
	mov rax, 90
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 1
	mov rsp, rbp
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
	mov rax, _string_1
	push rax
	mov rax, 95
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
	mov rsp, rbp
	pop rbp
	add rsp, 16
	ret
_hash_get:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, _string_1
	push rax
	mov rax, 102
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
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
	mov rax, _string_1
	push rax
	mov rax, 107
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, qword [rbp-16]
	mov rax, [rax+8]
	mov rsp, rbp
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
	mov rax, _string_1
	push rax
	mov rax, 112
	push rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp+8]
	push rax
	pop rdi
	mov al, 0
	call _is_hash
	push rax
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _my_assert
	mov rax, 0
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
	_string_4: db 105, 115, 95, 104, 97, 115, 104, 40, 72, 41, 0
	_string_2: db 72, 32, 33, 61, 32, 78, 85, 76, 76, 0
	_string_1: db 117, 116, 105, 108, 47, 104, 97, 115, 104, 46, 99, 0
	_string_3: db 99, 97, 112, 32, 62, 32, 48, 0
extern _fprintf
global _hash_insert
extern _strdup
global _is_hash
global _hash_get
extern _my_assert
global _hash_str
extern _strtol
extern _calloc
extern _malloc
extern _strncmp
extern _fclose
extern _getline
extern _free
extern _strndup
global _hash_new
global _key_index
global _are_chains_valid
global _hash_in
extern _hash_do_over
extern _fopen
extern _printf
extern _strcmp
extern _exit
