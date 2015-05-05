data T1 = E | A T2
data T2 = B T1


class Size a where
  size :: a -> Int

instance Size T1 where
  size E = 1
  size (A x) = 1 + size x

instance Size T2 where
  size (B x) = 1 + size x

instance Size a => Size [a] where
  size xs = length xs + sum [ size x | x <- xs ]


class Default a where
  some :: a

instance Default Int where
  some = 0

instance Default Bool where
  some = False

instance (Default a, Default b) => Default (a,b) where
  some = (some, some)
