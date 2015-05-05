import random as random

# def rand_tuple(): return (random.randint(0,99), random.randint(0,99))
def rand_tuple(): return (random.randint(0,99), random.randint(0,99))
def add_test(x,y): return x+y<100
def sub_test(x,y): return x-y>=0
def coinflip(): return random.randint(0,1)

def question(fun, operator):
    values = rand_tuple()
    if fun(*values):
        return "{} {} {} = {}".format(values[0], operator, values[1], '_'*14)
    else:
        return question(fun, operator)

for _ in range(20):
    fun, eq = (add_test, '+') if coinflip() else (sub_test, '-')
    print question(fun, eq)
