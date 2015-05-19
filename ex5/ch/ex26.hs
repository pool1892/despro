module Blueprint where
import Prelude
import MParserCore
import Aufgabe25 (exactly) -- steht zur Verfuegung
import Parser
import Test.QuickCheck

{- Betrachten Sie die folgenden Datentypen: -}

data Bit    = O | I                              deriving (Read, Show, Eq)
data Tree a = Leaf a | Node (Tree a) a (Tree a)  deriving (Show, Eq)

{- Schreiben Sie einen Parser, der (in Umkehrung des Effektes von show)
 - Stringrepraesentationen von Werten des Typs Tree Bit erkennt und 
 - umwandelt.
 -}

tree :: Parser (Tree Bit)
tree = leaf ||| node
  where 
    leaf = do exactly "Leaf " 
              c <- item
              yield undefined
    node = undefined

{- Es soll also insbesondere fuer alle t :: Tree Bit gelten:
 -
 -   parse tree (show t) == t
 -
 - Testbar mittels QuickCheck: -}

test = forAll (elements [1..6]) $ \(Blind h) -> forAll (sizedTree h) 
                                $ \t -> parse tree (show t) == t

instance Arbitrary Bit where
  arbitrary = elements [O,I]

sizedTree 0 = arbitrary >>= (return . Leaf)
sizedTree n = frequency [ (1, sizedTree 0), (2^n, branching) ]
  where branching = do t1 <- sizedTree (n-1)
                       a  <- arbitrary
                       t2 <- sizedTree (n-1)
                       return (Node t1 a t2)
