default rel
section .text

_test_hashes:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	and rsp, -16
	mov rax, 0
	mov rax, 30
	push rax
	pop rdi
	mov al, 0
	call _hash_new
	mov [rbp-8], rax
	mov rax, 0
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_1
	push rax
	mov rax, _string_2
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rax, 0
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_3
	push rax
	mov rax, _string_4
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _hash_insert
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_2
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 0
	mov rax, _string_5
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_4
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, _string_6
	push rax
	mov rax, qword [rbp-8]
	push rax
	mov rax, _string_7
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _hash_get
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _printf
	mov rax, 0
	mov rsp, rbp
	pop rbp
	add rsp, 0
	ret
_main:
	push rsi
	push rdi
	push rbp
	mov rbp, rsp
	sub rsp, 64
	and rsp, -16
	mov rax, 0
	mov al, 0
	call _test_hashes
	mov al, 0
	call _queue_new
	mov [rbp-8], rax
	mov rax, 0
	mov [rbp-16], rax
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
	mov [rbp-24], rax
	jmp label_2
label_1:
	mov rax, _string_8
	mov [rbp-24], rax
label_2:
	mov rax, 2
	push rax
	mov rax, qword [rbp+8]
	pop rcx
	cmp rax, rcx
	setg al
	movzx rax, al
	cmp rax, 0
	je label_3
	mov rax, 2
	imul rax, 8
	push rax
	mov rax, qword [rbp+16]
	pop rcx
	add rax, rcx
	mov rax, [rax]
	mov [rbp-32], rax
	jmp label_4
label_3:
	mov rax, _string_9
	mov [rbp-32], rax
label_4:
	mov rax, qword [rbp-24]
	push rax
	mov rax, _string_10
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fopen
	mov [rbp-40], rax
	mov rax, 0
	push rax
	mov rax, qword [rbp-40]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_5
	mov rax, _string_11
	push rax
	pop rdi
	mov al, 0
	call _printf
	mov rax, 1
	push rax
	pop rdi
	mov al, 0
	call _exit
label_5:
	mov rax, qword [rbp-32]
	push rax
	mov rax, _string_12
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _fopen
	mov [rbp-48], rax
	mov rax, qword [rbp-48]
	push rax
	pop rdi
	mov al, 0
	call _write_header
	mov al, 0
	call _env_new
	mov [rbp-56], rax
label_6:
	mov rax, 0
	push rax
	mov rax, qword [rbp-16]
	pop rcx
	cmp rax, rcx
	sete al
	movzx rax, al
	cmp rax, 0
	je label_7
	mov rax, qword [rbp-8]
	push rax
	mov rax, qword [rbp-40]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _parse_line
	mov [rbp-16], rax
	jmp label_6
label_7:
	mov rax, 0
label_8:
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _queue_empty
	test rax, rax
	setz cl
	movzx rax, cl
	cmp rax, 0
	je label_9
	mov rax, qword [rbp-8]
	push rax
	pop rdi
	mov al, 0
	call _parse
	mov [rbp-64], rax
	mov rax, qword [rbp-48]
	push rax
	mov rax, qword [rbp-64]
	push rax
	mov rax, qword [rbp-56]
	push rax
	pop rdx
	pop rsi
	pop rdi
	mov al, 0
	call _ast_write
	jmp label_8
label_9:
	mov rax, qword [rbp-48]
	push rax
	mov rax, qword [rbp-56]
	push rax
	pop rsi
	pop rdi
	mov al, 0
	call _write_footer
	mov rax, qword [rbp-48]
	push rax
	pop rdi
	mov al, 0
	call _fclose
	mov rax, 0
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
	_string_12: db 119, 0
	_string_11: db 70, 105, 108, 101, 32, 110, 111, 116, 32, 102, 111, 117, 110, 100, 10, 0
	_string_6: db 37, 100, 10, 0
	_string_1: db 97, 0
	_string_3: db 98, 0
	_string_4: db 98, 97, 115, 101, 98, 97, 108, 108, 115, 0
	_string_2: db 97, 112, 112, 108, 101, 115, 0
	_string_8: db 111, 98, 106, 47, 109, 97, 105, 110, 46, 99, 0
	_string_9: db 116, 101, 115, 116, 46, 97, 115, 109, 0
	_string_7: db 99, 97, 110, 100, 121, 0
	_string_5: db 37, 115, 10, 0
	_string_10: db 114, 0
extern _env_get_label
extern _parse_expr
extern _new_node_typedef
extern _new_node_struct
extern _sequence_empty
extern _fprintf
extern _env_deregister_end
extern _new_node_char
extern _hash_insert
extern _strdup
global _main
extern _env_set_fn
extern _new_node_sequence
extern _new_node_string
extern _type_add_field
extern _hash_get
extern _my_assert
extern _env_get_local_size
extern _hash_str
extern _strtol
extern _calloc
extern _malloc
extern _write_footer
extern _env_do_over_switches
extern _env_do_over_strings
extern _strncmp
extern _ast_write
extern _env_add_fn
extern _sequence_deq
extern _scope_add_local
extern _type_get_field
extern _parse_line
extern _queue_test
extern _fclose
extern _getline
extern _free
extern _env_register_end
extern _type_new_pointer
extern _env_get_string
extern _new_node_call
extern _type_new_fn
extern _strndup
extern _env_reg_fn
extern _parse_statement
extern _new_node_statement
extern _new_node_cast
extern _hash_new
extern _token_delete
extern _env_do_over_fns
extern _env_get_args_size
extern _new_node_switch
extern _new_node_binop
extern _write_header
extern _env_deregister_scope
extern _env_get_info
extern _pop
extern _ast_construct_scope
extern _enum_add_val
extern _new_node_for
extern _env_clear_fn
extern _env_new
extern _stack_empty
extern _queue_length
extern _env_register_scope
extern _new_node_sizeof
extern _env_get_type
extern _stack_new
extern _new_node_fn_arg
extern _new_node_break
extern _new_node_ternary
extern _new_node_arrow
extern _new_node_int
extern _scope_new
extern _token_peek
extern _peek
extern _type_get_size
extern _env_register_struct
extern _env_add_fn_arg
extern _push
extern _print_node
extern _type_print
extern _types_init
extern _hash_in
extern _queue_free
extern _env_do_over_vars
extern _new_node_enum
extern _type_pointer_inner
extern _env_ast_type
extern _env_get_field
extern _env_add_global
extern _new_node_while
extern _is_scope
extern _queue_empty
extern _env_last_end
extern _env_num_args
extern _new_node_unop
extern _type_new_base
extern _hash_do_over
extern _new_node_function
extern _new_node_case
extern _node_call_enq
extern _token_deq
extern _queue_readonly
extern _deq
extern _queue_new
extern _is_segment
extern _fopen
extern _env_add_enum_value
extern _new_node_if
extern _printf
extern _env_register_switch
extern _scope_find_local
extern _type_new_undet
extern _type_new_undet_struct
global _test_hashes
extern _env_register_typedef
extern _parse
extern _new_node_declaration
extern _str_token_type
extern _node_call_empty
extern _new_node_var
extern _type_new_struct
extern _strcmp
extern _sequence_enq
extern _node_call_deq
extern _token_enq
extern _enq
extern _token_new
extern _exit
