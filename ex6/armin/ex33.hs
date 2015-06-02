-- überführe list comprehension systematisch in einen Ausdruck ohne Verwendung von list comprehensions (siehe Vorlesung):

[ x ∗ x | x <- [ 1 .. 150 ], x ‘mod ‘ 4 == 0 ]
