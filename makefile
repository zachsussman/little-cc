CC=cc

TOK_DEPS = tokenizer/tokenize.h tokenizer/tokens.h 
TOK_OBJS = tokenizer/tokens.o tokenizer/tokenize.o 

UTIL_DEPS = util/list.h util/stack.h util/queue.h util/hash.h
UTIL_OBJS = util/list.o util/stack.o util/queue.o util/hash.o

PARSE_DEPS = parser/ast.h parser/parser.h parser/env.h parser/types.h
PARSE_OBJS = parser/ast.o parser/parser.o parser/env.o parser/types.c

WRITE_DEPS = writer/driver.h
WRITE_OBJS = writer/driver.o

MAIN_DEPS = token_q.h
MAIN_OBJS = token_q.o main.o

DEPS = $(TOK_DEPS) $(UTIL_DEPS) $(PARSE_DEPS) $(WRITE_DEPS) $(MAIN_DEPS)
OBJ = $(TOK_OBJS) $(UTIL_OBJS) $(PARSE_OBJS) $(WRITE_OBJS) $(MAIN_OBJS)

main: $(OBJ)
	cc -g -o $@ $^
	
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< 

test: main test.c
	cat test.c | ./main
	nasm -o test.o -f macho64 test.asm
	ld -lc test.o -o test /usr/lib/libc.dylib /usr/lib/crt1.o