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
              charToLeaf c
    node = do exactly "Node "
              char '('
              t1 <- tree
              exactly ") "
              c <- item
              exactly " ("
              t2 <- tree
              char ')'
              charToNode t1 c t2

charToBit :: Char -> Parser Bit
charToBit 'O' = return O
charToBit 'I' = return I
charToBit _ = failure

charToLeaf :: Char -> Parser (Tree Bit)
charToLeaf c = mapP Leaf (charToBit c)

charToNode :: Tree Bit -> Char -> Tree Bit -> Parser (Tree Bit)
charToNode t1 c t2 = mapP (\x -> Node t1 x t2) (charToBit c)

test = forAll (elements [1..6]) $ \(Blind h) -> forAll (sizedTree h)
                                $ \t -> parse tree (show t) == t

instance Arbitrary Bit where
  arbitrary = elements [O,I]

sizedTree 0 = liftP Leaf arbitrary
sizedTree n = frequency [ (1, sizedTree 0), (2^n, branching) ]
  where branching = do t1 <- sizedTree (n-1)
                       a  <- arbitrary
                       t2 <- sizedTree (n-1)
                       return (Node t1 a t2)
