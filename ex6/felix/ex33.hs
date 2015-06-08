-- überführe list comprehension systematisch in einen Ausdruck ohne Verwendung von list comprehensions (siehe Vorlesung):

[ x ∗ x | x <- [ 1 .. 150 ], x ‘mod ‘ 4 == 0 ]
[x*x|x<-[1..150], x‘mod‘4 == 0]
[x * x | x ‘mod‘ 4 == 0,c]) [1..150])

concat (map (\x -> [x * x | x ‘mod‘ 4 == 0]) [1..150])
concat (map (\x -> if (x ‘mod‘ 4 == 0) then (x * x) else []) [1..150])
