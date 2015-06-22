import Debug.Trace (trace)
import Prelude hiding (elem)

{-
trace :: String -> a -> a

Only for debugging!
-}

newtype T a = T {unT :: a}

instance (Show a, Eq a) => Eq (T a) where
  T x == T y = trace (show x ++ " == " ++ show y) (x == y)

elems :: Eq a => [a] -> [a]
elems = foldr (\x ys -> if elem x ys then ys else x:ys) []

elem :: Eq a => a -> [a] -> Bool
elem x = foldr (\y b -> x == y || b) False

main :: IO ()
main = print $ map unT $ elems $ map T [1,2,3,3,4,5,5,6]


