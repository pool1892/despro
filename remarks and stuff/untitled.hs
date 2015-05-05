data T1 = E| A T2
data T2 = B T1

class CountingAs a where
    as :: a -> Int

instance CountingAs T1 where
    as E = 0
    as (A x) =1 + as x


instance CountingAs T2 where
    as (B x) =as x


data T1 = E| A T2
data T2 = B T1

class Size a where
    as :: a -> Int

instance Size T1 where
    size E = 1
    size (A x) =1 + size x
instance Size T2 where
    size (B x) = 1+ size x
-- wenn nur länge der liste fürsize
instance Size [a] where
    size=length[]

--wenn rekursiv auch länge der elemente
instance Size [a] where
    size xs = length xs+ sum [size x|x <-xs]



-----------------------

class Default a where
    some :: a


instance Default Int where
    some = 0

instance Default Bool where
    some = False

instance (Default a, Default b)=> Default (a,b) where
    some= (some, some)




