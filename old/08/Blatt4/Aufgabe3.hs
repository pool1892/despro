
 merge l1 []                            = l1

 merge [] l2                            = l2

 merge  (e1 : l1) (e2 : l2) | e1 < e2   = (e1 : merge l1 (e2:l2))
                            | otherwise = (e2 : merge (e1:l1) l2)



 merge_sort []  = []

 merge_sort [e] = [e]

 merge_sort l   = merge (merge_sort links) (merge_sort rechts)

                  where (links,rechts) = splitAt (length l `div` 2) l



 merge_d l1 []                            = l1

 merge_d [] l2                            = l2

 merge_d  (e1 : l1) (e2 : l2) | e1 == e2  = merge_d (e1:l1) l2
                              | e1 < e2   = (e1 : merge_d l1 (e2:l2))
                              | otherwise = (e2 : merge_d (e1:l1) l2)



 merge_sort_d []  = []

 merge_sort_d [e] = [e]

 merge_sort_d l   = merge_d (merge_sort_d links) (merge_sort_d rechts)

                    where (links,rechts) = splitAt (length l `div` 2) l
