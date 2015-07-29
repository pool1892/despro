
 first 1 (x:xs)         = [ x ]

 first n (x:xs) | n > 1 = x : (first (n-1) xs)





 -- alle ganzen Zahlen:

 l1 = [ x*y | x <- [0 ..], y <- [-1, 1] ]

 -- ergibt Aufzählung: 0, 0, -1, 1, -2, 2, -3, 3, ...

 contains1 n = contains1_ n 0

 contains1_ n i | (l1 !! i == n) = True
                | otherwise      = contains1_ n (i+1)





 -- 2-Tupel natürlicher Zahlen:

 l2 = [ (a,summe-a) | summe <- [0 ..], a <- [0 .. summe] ]

 contains2 (n,m) = contains2_ (n,m) 0

 contains2_ (n,m) i | (l2 !! i == (n,m)) = True
                    | otherwise          = contains2_ (n,m) (i+1)





 -- 3-Tupel natürlicher Zahlen:

 l3 = [ (a,b, summe-(a+b)) | summe <- [0 ..], a <- [0 .. summe], b <- [0 .. (summe-a)]  ]

 contains3 (n,m,o) = contains3_ (n,m,o) 0

 contains3_ (n,m,o) i | (l3 !! i == (n,m,o)) = True
                      | otherwise            = contains3_ (n,m,o) (i+1)





 -- Tupel natürlicher Zahlen:
 -- Idee: verwende die Aufzählung von 2-Tupeln und ersetze jedes Tupel (a,b) durch alle a-Tupel mit
 --       der Element-Summe b

 l4 = [ x | (a,b) <- l2, x <- tupel a b ]

 tupel a b | a == 0    = []
           | a == 1    = [[b]]
           | otherwise = [ (x:y) | x <- [0 .. b], y <- tupel (a-1) (b-x)]












