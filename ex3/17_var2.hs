module Blueprint where
import Prelude
import Data.List
import Data.Maybe
import qualified Data.Array as Array  -- Diese Module/Datenstrukturen koennen genutzt werden,
import qualified Data.Map as Map      -- muessen aber natuerlich nicht - wie alle Imports.
import Test.QuickCheck

data Row    = A | B | C  deriving (Show, Read, Eq, Ord, Enum, Bounded, Array.Ix)
data Column = X | Y | Z  deriving (Show, Read, Eq, Ord, Enum, Bounded, Array.Ix)

type Pos = (Row, Column)
data Player = XX | OO | NA deriving (Eq)
data Field = Field [(Pos, Player)] deriving (Eq)

xPlayer :: Player
xPlayer = XX

oPlayer :: Player
oPlayer = OO

instance Show Field where
  show (Field x) = concatMap printFieldElem x

printFieldElem :: (Pos, Player) -> String
printFieldElem ((_,Z), pl) = show pl ++ "\n"
printFieldElem (pos, pl) = show pl ++"\t|\t"

instance Show Player where
  show NA = " "
  show XX = "X"
  show OO = "O"


initialField :: Field
initialField = Field [((x, y), NA)  | x <- [A, B, C], y <- [X, Y, Z]]


infixl 9 !
(!) ::  Field -> Pos -> Maybe Player
(!) (Field list) p | (p, NA) `elem` list = Nothing
                   | (p, XX) `elem` list = Just XX
                   | (p, OO) `elem` list = Just OO

possibleMoves :: Field -> [Pos]
possibleMoves f = movesForPlayer f NA

movesForPlayer :: Field -> Player -> [Pos]
movesForPlayer (Field f) p = map fst (filter (\a-> snd a==p) f)

makeMove :: Player -> Pos -> Field -> Field
makeMove p pos (Field f) = do
                  let index = fromJust (elemIndex (pos, NA) f)
                  Field (replaceNth index (pos, p) f)


replaceNth :: Int -> a -> [a] -> [a]
replaceNth n newVal (x:xs)
   | n == 0 = newVal:xs
   | otherwise = x:replaceNth (n-1) newVal xs

endPosition :: Field -> Maybe (Maybe Player)
endPosition f | won f XX = Just (Just XX)
              | won f OO = Just (Just OO)
              | null (possibleMoves f) = Just Nothing
              | otherwise = Nothing

won :: Field -> Player -> Bool
won f p =
  rows || cols || diag1 || diag2
    where rows = mapTest [(k, [v]) | (k, v) <- a]
          cols =  mapTest [(k, [v]) | (v, k) <- a]
          diag1 = length (a `intersect` [(A,X),(B,Y),(C,Z)]) == 3
          diag2 = length (a `intersect` [(C,X),(B,Y),(A,Z)]) == 3
          a = movesForPlayer f p


mapTest x = any (\x -> length (snd x) == 3) (Map.toList (Map.fromListWith (++) x))

{- Einige mit QuickCheck ausfuehrbare Tests: -}
test1 pos = isNothing (initialField ! pos)
test2 pos = pos `elem` possibleMoves initialField
test3 = isNothing (endPosition initialField)

{- Folgende Typklasseninstanzen werden nur benoetigt, um QuickCheck auf
 - die Spruenge zu helfen:
 -}

instance Arbitrary Row where
  arbitrary = elements [minBound .. maxBound]
instance Arbitrary Column where
  arbitrary = elements [minBound .. maxBound]


main = do
  print initialField
  print (makeMove XX (A,X) initialField)
  quickCheck test1
  quickCheck test2
