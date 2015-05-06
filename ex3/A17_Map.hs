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

data Player = XPlayer | OPlayer deriving Eq

instance Show Player where
  show XPlayer = "X"
  show OPlayer = "O"

xPlayer :: Player
xPlayer = XPlayer

oPlayer :: Player
oPlayer = OPlayer

newtype Field = Field (Map.Map Pos Player)
{-
Maps sind partielle Abbildungen, weshalb der Inhaltstyp einfach Player
sind kann (statt Maybe Player)
-}

instance Show Field where
  show f = intercalate horizontal (map showRow [A .. C])
    where horizontal = "\n--+---+--\n"
          showSquare (Just p) = show p
          showSquare Nothing  = " "
          showRow r = intercalate " | " (map (\c -> showSquare (f ! (r,c))) [X .. Z])

initialField :: Field
initialField = Field Map.empty

infixl 9 !
(!) ::  Field -> Pos -> Maybe Player
(!) (Field f) pos = Map.lookup pos f
-- Da Map.lookup fehlschlagen kann (Partialität), liefert es von sich aus Maybe Player zurück.

possibleMoves :: Field -> [Pos]
possibleMoves (Field f) = [ (r,c) | r <- [A .. C], c <- [X .. Z ], Map.notMember (r,c) f]

makeMove :: Player -> Pos -> Field -> Field
makeMove player pos (Field f) = Field (Map.insert pos player f)

endPosition :: Field -> Maybe (Maybe Player)
endPosition f | any (hasLine XPlayer) winningLines = Just (Just XPlayer)
              | any (hasLine OPlayer) winningLines = Just (Just OPlayer)
              | null (possibleMoves f)             = Just Nothing
              | otherwise                          = Nothing
  where hasLine player line = all (\pos -> f ! pos == Just player) line
        winningLines =    [[(r,c) | c <- [X .. Z]] | r <- [A .. C]]
                       ++ [[(r,c) | r <- [A .. C]] | c <- [X .. Z]]
                       ++ [ zip [A .. C] [X .. Z]]
                       ++ [ zip [A .. C] [Z, Y, X]]

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



