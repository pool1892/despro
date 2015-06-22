import           Prelude hiding (length)
import qualified Prelude (length)

length :: Num b => [a] -> b
length = fromInteger . toInteger . Prelude.length

mean :: Fractional a => [a] -> a
mean [] = error "mean []"
--mean xs = sum xs / length xs
mean xs = let (n,s) = foldr (\x (n,s) -> (n+1, s+x)) (0,0) xs in s / n

variance :: Fractional a => [a] -> a
variance xs = let (n,s1,s2) = foldr (\x (n,s1,s2) -> (n+1,s1+x,s2+(x-m)^2)) (0,0,0) xs
                  m = s1/n
              in s2 / n

