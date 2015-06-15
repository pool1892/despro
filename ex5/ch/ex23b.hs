module Blueprint where
import Test.QuickCheck
import Data.List


elems :: [Int] -> [Int]
elems xs = foldr (\x ys -> if elem' x ys then ys else x : ys) [ ] xs 

elem' :: Int -> [Int] -> Bool
elem' x xs=foldr (\y b->x==y||b) False xs

{-
Nub fängt "von links" an, während elem von rechts agiert und jeweils das größte oder kleinste Element, 
ein wenig wie foldl zu foldr, aber das ist nicht völlig korrekt

-}

-- Because it's funny:

f x= x

g x=elems x


testy wurst =  (f.nub.g) wurst == elems wurst