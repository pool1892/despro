from __future__ import print_function
from random import randint

def print_add(a, b):
    """Print addition"""
    return "{} + {} = _________".format(a, b)


def print_subtract(a, b):
    """Print subtraction"""
    return "{} - {} = _________".format(a, b)


def add_test(a, b):
    """Test if addition within bounds"""
    if a + b < 100:
        return (a,b)
    else:
        return generate(True)


def subtract_test(a, b):
    """Test if subtraction within bounds"""
    if a - b >= 0:
        return (a, b)
    else:
        return generate(False)


def generate(T):
    a, b = randint(0, 99), randint(0, 99)

    # Binary draw for variable assignment
    return add_test(a, b) if T else subtract_test(a, b)

def generate2():
    T = randint(0, 1)

    a, b = generate(T)
    # Binary draw for variable assignment
    print(print_add(a, b) if T else print_subtract(a, b))

    result = int(input("Ergebnis: "))

    correct_result = a+b if T else a-b
    is_correct = correct_result == result
    correction = "richtig" if is_correct else "falsch"
    print(correction)

if __name__ == '__main__':
    for i in range(20):
        generate2()
