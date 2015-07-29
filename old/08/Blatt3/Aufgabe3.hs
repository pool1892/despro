
 muenzen = [1, 2, 5, 10, 50]

 change a k | a < 0              = 0
            | (a >= 0 && k <= 0) = 0
            | k > length muenzen = 0
            | a == 0             = 1
            | otherwise          = change a (k-1) + change (a-(muenzen !! (k-1))) k
