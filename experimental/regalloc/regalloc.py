import pprint

# Statement := ra = rb + rc
#            | ra = *rb
#            | ra = CONST

# statement = (a, b, c) | (a, b) | (a)


program = [(0,),
           (1,),
           (2,),
           (3, 2),
           (4, 2, 3),
           (5, 4),
           (6, 4),
           (7, 4),
           (8, 5, 6),
           (9, 1, 6)]

free_regs = set(["a", "b"])

def find_assign(r, program):
    return [s for s in program if s[0] == r][0]

def needs(r, prog):
    statement = find_assign(r, prog)
    return statement[1:]

# Register allocation constraint:
# if a in needs(k, prog), a must be assigned at k

# Def horizon(r): max k such that r in needs(k, prog)

def find_horizons(program, regs):
    horizons = {r : 0 for r in range(regs)}
    for k in range(len(program)-1, -1, -1):
        st = program[k]
        if len(st) > 2:
            if horizons[st[2]] == 0:
                horizons[st[2]] = k
        if len(st) > 1:
            if horizons[st[1]] == 0:
                horizons[st[1]] = k
    return horizons

def removals(horizons, wrt):
    rems = []
    for r, t in horizons.items():
        if r != wrt:
            rems += [(t, r)]
    return sorted(rems, key=lambda a:a[0])






def linregalloc(prog, wrt):
    regs = max([item for sublist in prog for item in sublist]) + 1
    horizons = find_horizons(prog, regs)
    rem = removals(horizons, wrt)
    while len(rem) > 0 and rem[0][0] == 0: rem = rem[1:]
    s = set(["a", "b"])
    allocs = {}
    for t in range(len(prog)):
        stat = prog[t]
        while len(rem) > 0 and rem[0][0] == t:
            s.add(allocs[rem[0][1]])
            rem = rem[1:]
        if horizons[stat[0]] == 0 and stat[0] != wrt:
            continue
        if len(s) > 0:
            allocs[stat[0]] = s.pop()
        else:
            allocs[stat[0]] = "g"
    return allocs


# Two registers interfere if their live ranges overlap.  This is precisely when the first register's
# horizon is past the definition of the second register.

def interference_graph(horizons):
    regs = horizons.keys()
    g = {r:{r: 0 for r in regs} for r in regs}
    for r1 in sorted(regs):
        for r2 in sorted(regs):
            if r1 < r2 and horizons[r1] > r2:
                g[r1][r2] = 1
                g[r2][r1] = 1
    return g

print(linregalloc(program, 9))
print(interference_graph(find_horizons(program, 10)))


