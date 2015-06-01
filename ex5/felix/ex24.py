import random as random
import operator

def rand_tuple(): return (random.randint(0,99), random.randint(0,99))
def add_test(x,y): return x+y<100
def sub_test(x,y): return x-y>=0
def coinflip(): return random.randint(0,1)

ops = { "+": operator.add, "-": operator.sub }
def is_correct(op, values, answer):
  return ops[op](*values) == answer

def question(op, values):
  return "{} {} {} = {}".format(values[0], op, values[1], '_'*14)

def valid_values(pred):
  values = rand_tuple()
  return values if pred(*values) else valid_values(pred)

for _ in range(20):
  pred, op = (add_test, '+') if coinflip() else (sub_test, '-')
  values = valid_values(pred)
  print question(op, values)

  answer = int(raw_input("Ergebnis: "))
  print "Richtig!" if is_correct(op, values, answer) else "Falsch!"

