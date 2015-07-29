
 member x []        = False

 member x (y:ys)    | x == y = True

 member x (y:ys)    = member x ys



 elements []        = []

 elements (x:xs)    | member x xs = elements xs
                    | otherwise   = (x:(elements xs))



 union xs ys        = elements (xs ++ ys)

 intersection xs ys = elements [ x | x <- xs, member x ys]

 difference xs ys   = elements [ x | x <- xs, not (member x ys) ]

 product xs ys      = elements [ (x,y) | x <- xs, y <- ys ]



 subset [] ys       = True

 subset (x:xs) ys   | member x ys = subset xs ys
                    | otherwise = False



 equal m n          | subset m n && subset n m = True
                    | otherwise = False



 powset []          = [[]]
 powset (a:x)       = powset x ++ [a:y | y <- powset x]


 quer n             | n == 0 = 0 
                    | otherwise = quer (n `div` 10) + n `mod` 10

