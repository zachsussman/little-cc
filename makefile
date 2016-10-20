CC=cc
DEPS = tokenizer/tokenize.h tokenizer/tokens.h token_q.h
OBJ = tokenizer/tokens.o tokenizer/tokenize.o token_q.o main.o

main: $(OBJ)
	cc -o $@ $^
	
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< 

