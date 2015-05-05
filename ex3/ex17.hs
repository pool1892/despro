module Blueprint where
import Prelude
import Data.List
import Data.Maybe
import qualified Data.Array as Array  -- Diese Module/Datenstrukturen koennen genutzt werden,
import qualified Data.Map as Map      -- muessen aber natuerlich nicht - wie alle Imports.
import Test.QuickCheck

{- Stellen Sie sich vor, Sie wollen das Spiel TicTacToe implementieren.
 - 
 -   http://de.wikipedia.org/wiki/Tic_Tac_Toe
 - 
 - Zunaechst soll es nur um die Repraesentation des Spielfelds und
 - Operationen darauf gehen.
 - 
 - Vorgegeben sind die folgenden Typdefinitionen:
 -}
 {-
(B,Y),(C,Z),(B,X),(A,X),(A,Y),(A,Z),(C,Y)

main = do
    makeMove xPlayer (C,Y) (makeMove oPlayer (A,Z) (makeMove xPlayer (A,Y)(makeMove oPlayer (A,X) (makeMove xPlayer (B,X) (makeMove oPlayer (C,Z) (makeMove xPlayer (B,Y) initialField))))))
-}








data Row    = A | B | C  deriving (Show, Read, Eq, Ord, Enum, Bounded, Array.Ix)
data Column = X | Y | Z  deriving (Show, Read, Eq, Ord, Enum, Bounded, Array.Ix)

type Pos = (Row, Column)

{- Definieren Sie zunaechst eigene Typen 'Player' und 'Field' zur
 - Unterscheidung der beiden teilnehmenden Spieler sowie Repraesentation
 - einer konkreten Spielfeldsituation:
 -}



data Player = XX | OO | FF deriving (Eq, Show)

data Field = Feld [(Pos, Player)] deriving (Show, Eq)
{- Insbesondere soll es vom Typ 'Player' zwei Konstanten geben: -}
--instance Show Field where



xPlayer :: Player
xPlayer = XX

oPlayer :: Player
oPlayer = OO

{- Sorgen Sie ausserdem dafuer, dass 'Player' Instanz von 'Eq' ist, und
 - dass 'Field' Instanz von 'Show' ist, mit einer moeglichst sinnvollen
 - und ansprechenden "Ausgabe" des Spielfelds als String.
 -}


{- Schreiben Sie nun Definitionen wie folgend gefordert: -}

-- Repraesentation des leeren Spielfelds
initialField :: Field
initialField = Feld [((x,y), FF)| x<-[A,B,C], y<-[X,Y,Z]]


-- Lookup einer Position im Feld:
--   field ! pos = Nothing      ==>  die Position ist noch nicht besetzt
--   field ! pos = Just player  ==>  die Position wurde schon von dem
--                                   zurueckgelieferten Spieler besetzt

infixl 9 !
(!) ::  Field -> Pos -> Maybe Player
(!) (Feld thingy) posi | (posi, FF) `elem` thingy = Nothing
                    | (posi, XX) `elem` thingy = Just XX
                    | (posi, OO) `elem` thingy = Just OO

-- freie Positionen auf gegebenem Spielfeld (keine Position doppelt aufgezaehlt)
possibleMoves :: Field -> [Pos]
possibleMoves (Feld thingy) = [fst m | m <- thingy, snd m==FF]

-- Update des Spielfeldes mit Zug eines der beiden Spieler, wobei Sie annehmen
-- duerfen, dass nur tatsaechlich legale Zuege (entsprechend possibleMoves)
-- uebergeben werden
makeMove :: Player -> Pos -> Field -> Field
makeMove player position  (Feld field)= Feld (  delete (position, FF) field++  [(position, player)])



-- Test darauf, ob das Spiel beendet ist, und mit welchem Ergebnis:
--   endPosition field = Nothing       ==>  Spiel kann noch fortgesetzt werden
--   endPosition field = Just Nothing  ==>  Spiel ist beendet, mit Unentschieden
--   endPosition field = Just (Just player), wobei entweder player == xPlayer 
--                                                 oder     player == oPlayer
--                                     ==>  Spiel ist beendet, der zureckgelieferte
--                                          Spieler hat gewonnen
-- (Sie duerfen annehmen, dass nur echt im Spielverlauf erreichbare Situationen
--  ueberprueft werden, insbesondere keine Spielfelder, in denen beide Spieler
--  je alle drei Positionen in einer Reihe, Spalte oder Hauptdiagonale besetzt
--  haben.)

endPosition :: Field -> Maybe (Maybe Player)
endPosition (Feld test) | Feld test == initialField = Nothing
                     | testing (Feld test) XX = Just (Just XX)
                     | testing (Feld test) OO = Just (Just OO)
                     | null (possibleMoves (Feld test) )= Just Nothing
                     | otherwise =  Nothing

testing:: Field->Player->Bool
testing (Feld []) _ = False
testing (Feld feld) spieler = not (null (intersect (subi (Feld feld) spieler) (concat (map permutations [[(A,X),(A,Y),(A,Z)],[(B,X),(B,Y),(B,Z)],[(C,X),(C,Y),(C,Z)],[(A,X),(B,X),(C,X)],[(A,Y),(B,Y),(C,Y)],[(A,Z),(B,Z),(C,Z)],[(A,X),(B,Y),(C,Z)],[(A,Z),(B,Y),(C,X)]]))))


subi :: Field -> Player -> [[Pos]]
subi (Feld []) _=[]
subi (Feld thingy) spieler =  subsets [fst m|m<- thingy, snd m == spieler]


subsets :: [a] -> [[a]]
subsets []  = [[]]
subsets (x:xs) = subsets xs ++ map (x:) (subsets xs)



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
