	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_factorial
	.align	4, 0x90
_factorial:                             ## @factorial
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
	subq	$32, %rsp
	movl	%edi, -8(%rbp)
	cmpl	$2, -8(%rbp)
	jge	LBB0_2
## BB#1:
	leaq	L_.str(%rip), %rdi
	movl	-8(%rbp), %esi
	movb	$0, %al
	callq	_printf
	movl	$1, -4(%rbp)
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	jmp	LBB0_4
LBB0_2:
	cmpl	$2, -8(%rbp)
	jl	LBB0_4
## BB#3:
	leaq	L_.str.1(%rip), %rdi
	movl	-8(%rbp), %esi
	movb	$0, %al
	callq	_printf
	movl	-8(%rbp), %esi
	movl	-8(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %edi
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	movl	%esi, -20(%rbp)         ## 4-byte Spill
	callq	_factorial
	movl	-20(%rbp), %ecx         ## 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%rbp)
LBB0_4:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp5:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$10, %edi
	callq	_factorial
	leaq	L_.str.2(%rip), %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	_printf
	xorl	%esi, %esi
	movl	%eax, -4(%rbp)          ## 4-byte Spill
	movl	%esi, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Base case: %i\n"

L_.str.1:                               ## @.str.1
	.asciz	"Recursive: %i\n"

L_.str.2:                               ## @.str.2
	.asciz	"%i\n"


.subsections_via_symbols
