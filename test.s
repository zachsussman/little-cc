	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	$0, -4(%rbp)
	movl	%edi, -8(%rbp)
	movl	-8(%rbp), %edi
	movl	%edi, %eax
	movq	%rax, %rcx
	subq	$4, %rcx
	movq	%rax, -16(%rbp)         ## 8-byte Spill
	movq	%rcx, -24(%rbp)         ## 8-byte Spill
	ja	LBB0_6
## BB#8:
	leaq	LJTI0_0(%rip), %rax
	movq	-16(%rbp), %rcx         ## 8-byte Reload
	movslq	(%rax,%rcx,4), %rdx
	addq	%rax, %rdx
	jmpq	*%rdx
LBB0_1:
	movl	$1, %eax
	movl	%eax, %edi
	movb	$0, %al
	callq	_printf
	movl	%eax, -28(%rbp)         ## 4-byte Spill
LBB0_2:
	movl	$1, %eax
	movl	%eax, %edi
	movb	$0, %al
	callq	_printf
	movl	%eax, -32(%rbp)         ## 4-byte Spill
LBB0_3:
	movl	$1, %eax
	movl	%eax, %edi
	movb	$0, %al
	callq	_printf
	movl	%eax, -36(%rbp)         ## 4-byte Spill
LBB0_4:
	movl	$1, %eax
	movl	%eax, %edi
	movb	$0, %al
	callq	_printf
	movl	%eax, -40(%rbp)         ## 4-byte Spill
LBB0_5:
	movl	$1, %eax
	movl	%eax, %edi
	movb	$0, %al
	callq	_printf
	movl	%eax, -44(%rbp)         ## 4-byte Spill
LBB0_6:
	movl	$1, %eax
	movl	%eax, %edi
	movb	$0, %al
	callq	_printf
	movl	%eax, -48(%rbp)         ## 4-byte Spill
## BB#7:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
	.align	2, 0x90
L0_0_set_1 = LBB0_1-LJTI0_0
L0_0_set_2 = LBB0_2-LJTI0_0
L0_0_set_3 = LBB0_3-LJTI0_0
L0_0_set_4 = LBB0_4-LJTI0_0
L0_0_set_5 = LBB0_5-LJTI0_0
LJTI0_0:
	.long	L0_0_set_1
	.long	L0_0_set_2
	.long	L0_0_set_3
	.long	L0_0_set_4
	.long	L0_0_set_5


.subsections_via_symbols

	mov rbx, rax
	mov rdi, _string_1
	mov rsi, rax
	call _printf
	mov rax, rbx
