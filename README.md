# little-cc
A quick and dirty self-hosting C compiler.

## Running instructions
To make:
```
make
```
which produces `main`, an executable that takes in an assembly filename on the command line, reads in a C file from `stdout` and prints compiled NASM x86-64 assembly to the filename.

To self-compile:
```
make my_cc
```
which produces `my_cc`, taking a C filename and an assembly filename on the command line (much better).

To self-compile again, for fun:
```
make my_my_cc
```
which produces `my_my_cc`, which should be identical to `my_cc`, thus proving that this compiler is actually self-hosting.

To compile, say, test.c:
```
mkdir tmp
cc -E test.c -o tmp/test.c
my_cc tmp/test.c tmp/test.asm
nasm -o tmp/test.o -f your_object_format tmp/test.asm
ld -lc tmp/test.o -o test /path/to/libc
rm -rf tmp
```

To rid yourself of garbage:
```
make clean
```

## Supported Syntax
Implemented behavior includes:
 - Typed local and global variables, with declaration permitted anywhere and lexical scoping
 - The data types `int`, `char`, `void`, structs, typedefs, enums, and pointers
 - Strings
 - Function calls
 - Casting
 - All operators with correct precedence except for `.`, unary `+`/`-`, prefix increment/decrement, `%`, bitwise operators, comma, and combined assignment
 - `if`, `while`, `return`, `for`, `break`, and `switch` statements

Not implemented behavior includes, but is not limited to:
 - Inline assembly
 - Correct pointer arithmetic
 - Statically allocated structs or arrays
 - Static variables
 - Unions
 - Typechecking
 - Preprocessing
 - Gracefully recovering from errors
 - Optimization

Hey, I wrote a compiler in this, you'll be fine.

## Background
Basically, I was bored, so I decided to write a self-hosting compiler.  Since I was in 15-122 at Carnegie Mellon (which is taught in C), and since C fits in that sweet spot in the intersection of possible to write code in and possible to compile, I decided to write it in C.  (Alternatively, some might say that C sits in the sweet spot of unwritable and unreadable, in which case I doomed myself to failure.)

I was inspired by Noam Nisan and Shimon Schocken's fantastic [The Elements of Computing Systems](http://www.nand2tetris.org/), which takes you all the way from a NAND gate to programming Tetris and includes four chapters on simple compilers, and Jack Crenshaw's [Let's Build a Compiler](http://compilers.iecc.com/crenshaw/) series, partially building a Pascal self-compiler using the KISS principle.

## Technical notes

I basically chose the smallest subset of C that I wouldn't go crazy writing in.  I mean, could you imagine writing a compiler without structs or typing?

The compiler comes in three units, as is typical: a tokenizer, a parser, and a code generator.  The tokenizer produces a stream of tokens.  The parser parses this stream into an internal AST representation, which the code generator then walks down to directly produce x86-64 assembler, leading to correct but inefficient code.

Everything works on 64-bit Mac OS X, but I'm not sure how the C calling conventions change across operating systems and machines.  At least on my computer, I can call out to libc, etc.

Improvements that would be easy to implement include:
 - Implementing the rest of C
 - Basic optimizations like constant folding

Improvements that would be hard to implement and would likely entail rewriting a significant body of code include:
 - More involved optimizations like propagation analysis, SSA, loop unrolling and exchanging
 - More graceful error-checking
