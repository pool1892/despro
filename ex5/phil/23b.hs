module Blueprint where
import Prelude hiding (elem)
import Data.List hiding (elem)
import Test.QuickCheck

elems :: [Int] -> [Int]
elems = foldr (\x ys -> if elem x ys then ys else x : ys) []

elem :: Int -> [Int] -> Bool
elem x = foldr (\y b -> x == y || b) False

f = reverse
g = reverse

test xs = elems xs == (f.nub.g) xs
main = quickCheck test
