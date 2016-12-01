class Env():
    def __init__(self):
        self.regcount = 0
        self.varmap = {}

    def nextreg(self):
        self.regcount += 1
        return self.regcount

    def map_local(self, var):
        self.varmap[var] = self.nextreg()
        return self.varmap[var]


    def get_local_map(self, var):
        return self.varmap[var]


class Var():
    def __init__(self, name):
        self.name = name

    def write(self, ls, env):
        return env.get_local_map(self.name)

class Number():
    def __init__(self, val):
        self.val = int(val)

    def write(self, ls, env):
        r = env.nextreg()
        ls += [("const", r, self.val)]
        return r

class Binop():
    def __init__(self, left, right):
        self.left = left
        self.right = right

def ArithBinop(opname):
    class AB(Binop):
        def write(self, ls, env):
            reg = env.nextreg()
            l = self.left.write(ls, env)
            r = self.right.write(ls, env)
            ls += [(opname, reg, l, r)]
            return reg

    return AB

Add = ArithBinop("add")
Sub = ArithBinop("sub")
Mult = ArithBinop("mul")
Div = ArithBinop("div")

class Assign(Binop):
    def write(self, ls, env):
        reg = env.map_local(self.left.name)
        ls += [("assign", reg, self.right.write(ls, env))]
        return reg

class Statement():
    def __init__(self, expr):
        self.expr = expr

    def write(self, ls, env):
        self.expr.write(ls, env)

class Block():
    def __init__(self, ls):
        self.ls = ls

    def write(self, ls, env):
        for l in self.ls:
            l.write(ls, env)


def expect(tokens, c):
    if tokens[0] == c:
        tokens.popleft()
    else:
        raise Exception("Expected " + c + ", got " + tokens[0])

def parse_term(tokens):
    if tokens[0] == "(":
        expect(tokens, "(")
        inner = parse_expr(tokens)
        expect(tokens, ")")
        return inner
    elif "0" <= tokens[0][0] <= "9":
        return Number(tokens.popleft())
    else:
        return Var(tokens.popleft())

def parse_left_assoc(mapping, inner):
    def p_inner(tokens):
        left = inner(tokens)
        while len(tokens) > 0 and tokens[0] in mapping.keys():
            t = tokens.popleft()
            right = inner(tokens)
            left = mapping[t](left, right)
        return left
    return p_inner

def parse_right_assoc(mapping, inner):
    def p_inner(tokens):
        left = inner(tokens)
        if len(tokens) > 0 and tokens[0] in mapping.keys():
            t = tokens.popleft()
            right = p_inner(tokens)
            return mapping[t](left, right)
        return left
    return p_inner


parse_mul = parse_left_assoc({"*": Mult, "/": Div}, parse_term)
parse_add = parse_left_assoc({"+": Add, "-": Sub}, parse_mul)
parse_assign = parse_right_assoc({"=": Assign}, parse_add)
parse_expr = parse_assign


def parse_semi_statement(tokens):
    inner = parse_expr(tokens)
    expect(tokens, ";")
    return Statement(inner)

def parse_block(tokens):
    expect(tokens, "{")
    l = []
    while tokens[0] != "}":
        l += [parse_semi_statement(tokens)]
    expect(tokens, "}")
    return Block(l)

def parse(tokens):
    return parse_block(tokens)
