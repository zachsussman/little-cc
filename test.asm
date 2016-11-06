default rel
section .text

_main:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rax, qword [rbp-8]
	mov rax, [rax+8]
	add rsp, 16
	pop rbp
	add rsp, 0
	ret
	
section .data
	dummy: dw 16
global _main
