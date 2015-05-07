compress [] = []
compress xs = head xs : map snd (filter (uncurry (/=)) (zip xs (tail xs)))
