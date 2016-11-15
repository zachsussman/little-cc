CC=cc

TOK_DEPS = tokenizer/tokenize.h tokenizer/tokens.h 
TOK_OBJS = tokenizer/tokens.o tokenizer/tokenize.o 

UTIL_DEPS = util/list.h util/stack.h util/queue.h util/hash.h
UTIL_OBJS = util/list.o util/stack.o util/queue.o util/hash.o

PARSE_DEPS = parser/ast.h parser/parser.h parser/env.h parser/types.h parser/scope.h
PARSE_OBJS = parser/ast.o parser/parser.o parser/env.o parser/types.c parser/scope.c

WRITE_DEPS = writer/driver.h
WRITE_OBJS = writer/driver.o

MAIN_DEPS = token_q.h diff.h
MAIN_OBJS = token_q.o main.o

DEPS = $(TOK_DEPS) $(UTIL_DEPS) $(PARSE_DEPS) $(WRITE_DEPS) $(MAIN_DEPS)
OBJ = $(TOK_OBJS) $(UTIL_OBJS) $(PARSE_OBJS) $(WRITE_OBJS) $(MAIN_OBJS)

main: $(OBJ)
	cc -g -o $@ $^
	
%.o: %.c $(DEPS)
	$(CC) -O3 -c -o $@ $< 

lean: $(OBJ)
	cc -o $@ $^

test: main test.c
	cat test.c | ./main
	nasm -o test.o -f macho64 test.asm
	ld -lc test.o -o test /usr/lib/libc.dylib /usr/lib/crt1.o

link_my_cc: 
	ld -lc obj/util/list.o obj/util/queue.o obj/util/hash.o obj/util/stack.o \
		obj/tokenizer/tokens.o obj/tokenizer/tokenize.o \
		obj/incmain.o obj/token_q.o obj/contracts.o \
		obj/parser/ast.o obj/parser/parser.o \
		obj/parser/types.o  obj/parser/scope.o \
		obj/parser/env.o obj/writer/driver.o \
		-o my_cc /usr/lib/libc.dylib /usr/lib/crt1.o

my_cc: 
	./my_cc.sh incmain
	./my_cc.sh token_q
	./my_cc.sh contracts
	./my_cc.sh tokenizer/tokens
	./my_cc.sh tokenizer/tokenize
	./my_cc.sh util/list
	./my_cc.sh util/queue
	./my_cc.sh util/hash
	./my_cc.sh util/stack
	./my_cc.sh parser/ast
	./my_cc.sh parser/parser
	./my_cc.sh parser/types
	./my_cc.sh parser/scope
	./my_cc.sh parser/env
	./my_cc.sh writer/driver
	ld -lc obj/util/list.o obj/util/queue.o obj/util/hash.o obj/util/stack.o \
		obj/tokenizer/tokens.o obj/tokenizer/tokenize.o \
		obj/incmain.o obj/token_q.o obj/contracts.o \
		obj/parser/ast.o obj/parser/parser.o \
		obj/parser/types.o  obj/parser/scope.o \
		obj/parser/env.o obj/writer/driver.o \
		-o my_cc /usr/lib/libc.dylib /usr/lib/crt1.o
		
my_cc_test: 
	./test test.c
	nasm -o test.o -f macho64 test.asm
	ld -lc test.o -o my_test /usr/lib/libc.dylib /usr/lib/crt1.o

my_my_cc:
	./my_my_cc.sh incmain
	./my_my_cc.sh token_q
	./my_my_cc.sh contracts
	./my_my_cc.sh tokenizer/tokens
	./my_my_cc.sh tokenizer/tokenize
	./my_my_cc.sh util/list
	./my_my_cc.sh util/queue
	./my_my_cc.sh util/hash
	./my_my_cc.sh util/stack
	./my_my_cc.sh parser/ast
	./my_my_cc.sh parser/parser
	./my_my_cc.sh parser/types
	./my_my_cc.sh parser/scope
	./my_my_cc.sh parser/env
	./my_my_cc.sh writer/driver
	ld -lc obj2/util/list.o obj2/util/queue.o obj2/util/hash.o obj2/util/stack.o \
		obj2/tokenizer/tokens.o obj2/tokenizer/tokenize.o \
		obj2/incmain.o obj2/token_q.o obj2/contracts.o \
		obj2/parser/ast.o obj2/parser/parser.o \
		obj2/parser/types.o  obj2/parser/scope.o \
		obj2/parser/env.o obj2/writer/driver.o \
		-o my_my_cc /usr/lib/libc.dylib /usr/lib/crt1.o