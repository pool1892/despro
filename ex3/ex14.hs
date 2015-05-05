module Blueprint where
import Prelude
import Data.Maybe
import Test.QuickCheck
import Data.List


data Bit = O | I  deriving (Eq, Show)



encode :: [[Bool]] -> [Bit]
encode [] = []
encode (x:xs) = tobit x  ++  encode xs 

tobit :: [Bool] -> [Bit]
tobit [] = [I,I,I]
tobit (x:xs)  | x = O:I:O: tobit xs
              |otherwise = O:O:O: tobit xs




decode::[Bit] -> Maybe [[Bool]]
decode []=Just []
decode xs |checkfaulty (frombit xs)=Nothing
          | otherwise = Just (make (frombit xs))

make::[Int]->[[Bool]]
make []=[]
make xs= tobool (takeWhile (/=2) xs) : make (tail (dropWhile (/=2) xs))

checkfaulty:: [Int]->Bool
checkfaulty []=False
checkfaulty xs = last xs /= 2 || elem 3 xs  

frombit :: [Bit] -> [Int]
frombit []=[]
frombit xs | length xs `mod` 3/=0  = [3]
frombit (O:I:O:xs) =  1:frombit xs
frombit (O:O:O:xs) = 0:frombit xs
frombit (I:I:I:xs)= 2:frombit xs
frombit (_:_:_:xs)=[3]


tobool:: [Int]->[Bool]
tobool[]=[]
tobool (0:xs)= False: tobool xs
tobool (1:xs)= True: tobool xs



    
{-


Christophs-MacBook-Pro:ex3 hh$ hlint ex14.hs 
ex14.hs:13:1: Warning: Use foldr
Found:
  encode [] = []
  encode (x : xs) = tobit x ++ encode xs
Why not:
  encode xs = foldr ((++) . tobit) [] xs

1 suggestion
 -}

test1 v = decode (encode v) == Just v

test2 c = let mv = decode c 
          in isJust mv
             ==> encode (fromJust mv) == c

{- Folgende Typklasseninstanz wird wieder nur benoetigt, um QuickCheck auf
 - die Spruenge zu helfen:
 -}

instance Arbitrary Bit where
  arbitrary = elements [O,I]
