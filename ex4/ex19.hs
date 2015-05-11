module Blueprint where
import Prelude
import Data.Maybe
import Test.QuickCheck

{- Betrachten Sie folgende Datentypen: -}

data Bit = O | I  deriving (Eq, Show)

data Tree = Leaf Bool | Node Tree Tree  deriving (Eq, Show)

{- und schreiben Sie zu folgender Funktion: -}

encode :: Tree -> [Bit]
encode (Leaf b)   = [O, bool2bit b]
encode (Node l r) = I : encode l ++ encode r

bool2bit :: Bool -> Bit
bool2bit False = O
bool2bit True  = I

bit2bool :: Bit -> Bool
bit2bool O = False
bit2bool I  = True

{- eine Funktion: -}

decode :: [Bit] -> Maybe Tree
decode c = if isJust a && null y then Just x else Nothing
  where (x,y) = fromJust (decode' c)
        a = decode' c

decode' :: [Bit] -> Maybe (Tree, [Bit])
decode' [] = Nothing
decode' [x] = Nothing
decode' [I,_] = Nothing
decode' (O:x:xs) = Just (Leaf (bit2bool x), xs)
decode' (I:xs) = case pairMaybe d e of
  Nothing -> Nothing
  otherwise -> Just (Node a f, g)
  where (a, b) = fromJust d
        (f, g) = fromJust e
        e = decode' b
        d = decode' xs


pairMaybe :: Maybe a -> Maybe b -> Maybe (a,b)
pairMaybe (Just a) (Just b) = Just (a,b)
pairMaybe _        _        = Nothing

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
