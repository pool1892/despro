module Blueprint where
import Prelude

genQuer :: Integer -> Bool -> Integer -> Integer
genQuer size alternate b =
  s (getGroupings size b)
  where s = if alternate then alternateSum else sum

alternateSum :: [Integer] -> Integer
alternateSum a =
  if b < 0 then f (map negate a) else b
  where b = f a
        f = foldr (-) 0

getGroupings :: Integer -> Integer -> [Integer]
getGroupings size 0   = []
getGroupings size num = m:getGroupings size n
             where (n, m) = num `divMod` (10^size)

main = do
  print (genQuer 3 False 1234567 == 802)
  print (genQuer 3 True  1234567 == 334)
  print (genQuer 2 True  54321 == 17)
