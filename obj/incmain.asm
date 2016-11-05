default rel
section .text

_main:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov al, 0
	call _queue_new
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
	mov rax, _string_1
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	cmp rax, 0
	je label_1
	mov rax, 1
	imul rax, 8
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
	jmp label_2
label_1:
	mov rax, _string_2
	push rax
	lea rax, [rbp-24]
	pop rcx
	mov [rax], rcx
label_2:
	mov rax, qword [rbp-24]
	push rax
	mov rax, _string_3
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fopen
	mov [rbp-32], rax
label_3:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_4
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-32]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_line
	push rax
	lea rax, [rbp-16]
	pop rcx
	mov [rax], rcx
	jmp label_3
label_4:
label_5:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_6
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _token_deq
	mov [rbp-40], rax
	mov rax, _string_4
	push rax
	mov rax, qword [rbp-40]
	mov rax, [rax+8]
	push rax
	mov rax, qword [rbp-40]
	mov rax, [rax+0]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	jmp label_5
label_6:
	mov rax, 0
	add rsp, 48
	pop rbp
	add rsp, 16
	ret
	add rsp, 48
	pop rbp
	add rsp, 16
	ret
	
section .data
	dummy: dw 16
	_string_2: db 109, 97, 105, 110, 46, 99, 0
	_string_4: db 37, 115, 32, 37, 105, 10, 0
	_string_1: db 65, 108, 108, 111, 99, 97, 116, 101, 100, 32, 101, 39, 114, 121, 116, 104, 105, 110, 103, 10, 0
	_string_3: db 114, 0
extern _env_register_struct
extern _env_get_string
extern _sequence_empty
extern _new_node_call
extern _token_delete
extern _env_do_over_vars
extern _push
extern _new_node_cast
extern _env_clear_fn
extern _new_node_switch
extern _type_new_undet_struct
extern _env_get_args_size
extern _env_num_args
extern _queue_length
extern _write_footer
extern _type_new_fn
extern _hash_in
extern _env_ast_type
extern _type_add_field
extern _type_new_struct
extern _queue_test
extern _getline
extern _new_node_if
extern _env_last_end
extern _enum_add_val
extern _new_node_function
extern _new_node_binop
extern _env_add_enum_value
extern _env_register_switch
extern _env_get_info
extern _new_node_string
extern _new_node_var
extern _ast_write
extern _pop
extern _stack_new
extern _calloc
extern _printf
extern _write_header
extern _env_get_field
extern _new_node_enum
extern _new_node_struct
extern _hash_insert
extern _queue_readonly
extern _queue_empty
extern _strncmp
extern _type_get_size
extern _env_add_fn_locals
extern _queue_new
extern _env_get_type
extern _stack_empty
extern _new_node_break
extern _new_node_arrow
extern _str_token_type
extern _exit
extern _env_add_global
extern _new_node_unop
extern _type_new_undet
extern _parse_line
extern _strcmp
extern _env_get_local_size
extern _env_new
global _main
extern _env_register_typedef
extern _new_node_case
extern _type_print
extern _types_init
extern _env_do_over_strings
extern _env_set_fn
extern _env_add_fn_arg
extern _print_node
extern _new_node_fn_arg
extern _env_do_over_fns
extern _sequence_deq
extern _new_node_while
extern _hash_new
extern _fopen
extern _free
extern _malloc
extern _new_node_declaration
extern _env_get_label
extern _env_add_fn
extern _new_node_for
extern _new_node_statement
extern _type_pointer_inner
extern _type_new_base
extern _env_register_end
extern _parse
extern _type_new_pointer
extern _node_call_deq
extern _node_call_empty
extern _hash_do_over
extern _token_deq
extern _deq
extern _env_do_over_switches
extern _new_node_char
extern _hash_str
extern _queue_free
extern _ast_locals
extern _sequence_enq
extern _new_node_int
extern _hash_get
extern _token_peek
extern _is_segment
extern _new_node_sequence
extern _type_get_field
extern _env_deregister_end
extern _new_node_typedef
extern _new_node_sizeof
extern _peek
extern _node_call_enq
extern _token_enq
extern _enq
extern _token_new
