#!/usr/bin/env bash

cc -D MY_CC -E $1.c > obj2/$1.c && time ./my_cc obj2/$1.c obj2/$1.asm && nasm -o obj2/$1.o -f macho64 obj2/$1.asm