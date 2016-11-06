#!/usr/bin/env bash

cc -D MY_CC -E $1.c > obj/$1.c && ./main <obj/$1.c obj/$1.asm && nasm -o obj/$1.o -f macho64 obj/$1.asm