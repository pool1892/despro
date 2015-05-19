module Blueprint where
import Prelude
import Data.Maybe
import Test.QuickCheck


data Bit = O | I  deriving (Eq, Show)

data Tree = Leaf Bool | Node Tree Tree  deriving (Eq, Show)


encode :: Tree -> [Bit]
encode (Leaf b)   = [O, bool2bit b]
encode (Node l r) = I : encode l ++ encode r

bool2bit :: Bool -> Bit
bool2bit False = O
bool2bit True  = I


decode :: [Bit] -> Maybe Tree
decode x = case decode' x of
        Just (y,[])-> Just y
        otherwise -> Nothing

decode' :: [Bit] -> Maybe (Tree, [Bit])
decode' [] = Nothing
decode' [x] = Nothing
decode' [I,_] = Nothing
decode' (O:x:xs) = Just (Leaf (x==I), xs)
decode' (I:xs) = maybebaby (decode' xs) (rechts xs)
  where rechts= decode'.snd.fromJust .decode'
        maybebaby (Just (a,b)) (Just (c,d)) = Just (Node a c,d)
        maybebaby _        _        = Nothing
--Could have used the function "maybe"...which is nice





test1 v = decode (encode v) == Just v
test2 c = let mv = decode c
          in isJust mv
             ==> encode (fromJust mv) == c

instance Arbitrary Bit where
  arbitrary = elements [O,I]

instance Arbitrary Tree where
   arbitrary = sized treegen
     where treegen n | n <= 1 = fmap Leaf arbitrary
           treegen n          = do i <- elements [0 .. n-1]
                                   l <- treegen i
                                   r <- treegen (n-1-i)
                                   return (Node l r)


main = do
  quickCheck test1
  quickCheck test2
