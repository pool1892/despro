module Blueprint where
import Prelude
import Test.QuickCheck (verboseCheck, NonNegative(..))

{-
 - Geben Sie in Haskell definierte unendliche Listen an fuer:
 -}

-- 1. die Menge aller ganzen Zahlen,
ints :: [Integer]
ints = [x*(-1)^t|t<-[0,1],x<-[1..]]

-- 2. die Menge aller Paare von natuerlichen Zahlen,
pairs :: [(Integer,Integer)]
pairs = [(x,y)|x<-[1..]|y<-[1..]]

-- 3. die Menge aller Tripel von zwei natuerlichen und einer ganzen Zahl.
triples :: [(Integer,Integer,Integer)]
triples = undefined

{- 
 - Es sollen also die den wie folgt formulierbaren Tests entsprechenden
 - allgemeinen Aussagen gelten (und keine der Listen doppelte oder
 - ueberfluessige Elemente enthalten):
 - 
 - test1 = verboseCheck $ \n -> elem n ints
 - 
 - test2 = verboseCheck $ \(NonNegative n, NonNegative m) -> elem (n,m) pairs
 - 
 - test3 = verboseCheck $ \(NonNegative n, NonNegative m, p) -> elem (n,m,p) triples
 -}
