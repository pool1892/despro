module Blueprint where
import Prelude

data Tree = Tree Int [Tree] deriving (Show)

has :: Int -> Tree -> Bool
has n (Tree a []) = n==a
has n (Tree a b) | n==a = True
                      | otherwise = any (has n) b

main = do
  let myTree = Tree 5 [Tree 1 [Tree 6 []], Tree 8 [], Tree 2 [Tree 1 [], Tree 4 []]]
  print (has 100 myTree)
  print (has 6 myTree)
  print myTree
