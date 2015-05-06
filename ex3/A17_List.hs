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

newtype Field = Field [Maybe Player]
-- Feld wird zeilenweise als Liste kodiert

instance Show Field where
  show f = intercalate horizontal (map showRow [A .. C])
    where horizontal = "\n--+---+--\n"
          showSquare (Just p) = show p
          showSquare Nothing  = " "
          showRow r = intercalate " | " (map (\c -> showSquare (f ! (r,c))) [X .. Z])

initialField :: Field
initialField = Field (replicate 9 Nothing)

infixl 9 !
(!) ::  Field -> Pos -> Maybe Player
(!) (Field f) (r,c) = f !! (3 * fromEnum r + fromEnum c)
-- fromEnum verwandelt Row bzw Column in Int

possibleMoves :: Field -> [Pos]
possibleMoves f = [(r,c) | r <- [A .. C], c <- [X .. Z ], isNothing (f ! (r,c))]

makeMove :: Player -> Pos -> Field -> Field
makeMove player (r,c) (Field f) = 
  let i = 3 * fromEnum r + fromEnum c
      (front, _: end) = splitAt i f
  in Field (front ++ [Just player] ++ end)
-- gleicher Trick wie oben, plus splitAt um die Liste aufzuteilen

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



