from collections import deque
from ast import parse, Env

class Tokenizer():
    def __init__(self, f):
        self.file = f
        self.tokens = deque()

    def tokenize(self):
        lines = self.file.readlines()
        for l in lines:
            self.tokenize_line(l)

    def tokenize_line(self, line):
        index = 0
        while index < len(line):
            c = line[index]
            if c in [" ", "\t", "\n"]:
                index += 1
            elif "a" <= c <= "z" or "A" <= c <= "Z" or c == "_":
                index = self.parse_name(line, index)
            elif "0" <= c <= "9":
                index = self.parse_number(line, index)
            else:
                index = self.parse_op(line, index)
        return

    def parse_seq(self, line, index, classify):
        name = ""
        while index < len(line) and classify(line[index]):
            name += line[index]
            index += 1
        self.tokens.append(name)
        return index


    def parse_name(self, line, index):
        def is_name_char(c):
            return "a" <= c <= "z" or "A" <= c <= "Z" or "0" <= c <= "9" or c == "_"
        return self.parse_seq(line, index, is_name_char)

    def parse_number(self, line, index):
        def is_num_char(c):
            return "0" <= c <= "9"
        return self.parse_seq(line, index, is_num_char)

    def parse_op(self, line, index):
        c = line[index]
        if index == len(line) - 1:
            self.tokens.append(c)
            return len(line)

        def multop(a, b):
            if c == a and line[index+1] == b:
                self.tokens.append(a+b)
                return True
            else:
                return False

        if not (multop("+", "+") or multop("-", "-") or multop("-", ">") or multop(">", "=") or multop("<", "=")
                or multop("=", "=") or multop("&", "&") or multop("|", "|") or multop("!", "=")):
            self.tokens.append(c)
            return index+1
        else:
            return index+2




filename = "test.c"
f = open(filename, mode="r")
tokenizer = Tokenizer(f)
tokenizer.tokenize()
f.close()
tree = parse(tokenizer.tokens)
env = Env()
ls = []
tree.write(ls, env)

for line in ls:
    print(line)

