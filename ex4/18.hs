module Blueprint where
import Prelude
import Data.List
import Data.Maybe
import Aufgabe17 (Pos, Player, Field, xPlayer, oPlayer,
                  possibleMoves, makeMove, endPosition, exampleMoves, initialField)

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
outlook p f = case endPosition f of
    Just Nothing  -> Draw
    Just (Just _) -> Lost
    Nothing       -> Continue (map (\pos->(pos, outlook (switch p) (makeMove p pos f))) (possibleMoves f))

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

Play :: Player -> [Pos] -> Field -> Field
Play p [] f = f
Play p [x] f = makeMove p x f
Play p (x:xs) f= Play (switch p) xs (makeMove p x f)


main = do
  let a = Play xPlayer exampleMoves initialField
  print a

  let o = outlook xPlayer a
  print o
