module Aufgabe18 where
import Prelude
import Data.List
import Data.Maybe
import qualified Data.Array as Array  -- Diese Module/Datenstrukturen koennen genutzt werden,
import qualified Data.Map as Map      -- muessen aber natuerlich nicht - wie alle Imports.
import Test.QuickCheck
{- Wir setzen die Aufgabe zu TicTacToe fort. Nehmen Sie an, Implementierungen aus
 - Aufgabe 17 wie oben angefuehrt seien gegeben, Sie haben hier jedoch keinen
 - Zugriff auf die internen Repraesentationen von 'Pos', 'Player', 'Field'.
 -
 - Gegeben sei ferner noch folgende Hilfsfunktion:
 -}

switch :: Player -> Player
switch player | player == xPlayer = oPlayer
              | player == oPlayer = xPlayer

{- Ihre Aufgabe besteht darin, fuer einen gegebenen Spieler in einer gegebenen Situation
 - den Spielbaum aller moeglichen weiteren Entwicklungen zu erzeugen:
 -}
data GameTree = Lost | Draw | Continue [ (Pos, GameTree) ]  deriving Show

outlook :: Player -> Field -> GameTree
outlook player field | lost = Lost
                     | draw = Draw
                     | otherwise = Continue [(x,outlook (switch player) (makeMove player x field))|x<-moves]
                            where moves = possibleMoves field
                                  lost = endPosition field == Just (Just (switch player))
                                  draw = null moves && endPosition field == Just Nothing
                                  movetree= permutations moves
                                  -- f (x:xs)= fst x : outlook (switch player) (makeMove player (fst x) field)
                                  -- collection= map f movetree


{- Dabei bedeuten 'Lost' und 'Draw', dass der entsprechende Spieler in der gegebenen
 - Situation verloren hat bzw. ein Unentschieden erreicht ist. Ist noch keiner dieser
 - beiden Faelle eingetreten, wird mittels 'Continue' eine Liste von Paaren der gerade
 - moeglichen Zuege und der Beschreibung der jeweiligen weiteren Spielentwicklung
 - aus der Sicht des sich dann am Zug befindenden Gegenspielers repraesentiert.
 -
 - (Hinweis: Der Grund dafuer dass es in GameTree keinen Datenkonstruktor Win gibt,
 -           ist dass man nie am Zug sein und schon gewonnen haben kann. Ein Gewinn
 -           ist nur *nach* einem eigenen Zug moeglich, aber dann ist schon der
 -           Gegenspieler am Zug - und hat verloren.)
 -
 - Beispiel:
 - ---------
 -
 -   Ist das aktuelle Spielfeld wie folgt:
 -
 -       X Y Z
 -     A:X O .
 -     B:X X O
 -     C:. . O
 -
 -   und xPlayer ist am Zug, dann ist ein korrekter Wert von 'outlook xPlayer field':
 -
 -     Continue [((A,Z),Continue [((C,X),Continue [((C,Y),Draw)]),
 -                                ((C,Y),Continue [((C,X),Lost)])]),
 -               ((C,X),Lost),
 -               ((C,Y),Continue [((A,Z),Lost),
 -                                ((C,X),Continue [((A,Z),Draw)])])]
 -
 -   Denn wenn xPlayer etwa (C,X) zieht, dann hat der Gegenspieler verloren.
 -   Andererseits, wenn xPlayer (C,Y) zieht, dann kann anschliessend oPlayer (A,Z)
 -   ziehen und xPlayer hat verloren, oder oPlayer antwortet stattdessen mit (C,X),
 -   woraufhin xPlayer nur mit (A,Z) fortsetzen kann, was zu einem Unentschieden fuehrt.
 -   Und wenn xPlayer in der Ausgangssituation (A,Z) zieht, dann ergeben sich fuer
 -   oPlayer die Alternativen (C,X) und (C,Y) mit entsprechenden Fortsetzungen.
 -
 -   Fuer die Korrektheit eines GameTree soll nicht entscheidend sein, in welcher
 -   Reihenfolge die Teilbaeume bei Verzweigungen in der jeweiligen Liste auftreten.
 -   Tatsaechlich waere oben also etwa auch korrekt:
 -
 -     Continue [((C,X),Lost),
 -               ((C,Y),Continue [((C,X),Continue [((A,Z),Draw)]),((A,Z),Lost)]),
 -               ((A,Z),Continue [ ... ])]
 -}

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
