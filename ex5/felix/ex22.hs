module Blueprint where
import Prelude
import Data.List
import Data.Maybe
import Aufgabe17 (Pos, Player, xPlayer, oPlayer)
import Aufgabe18 (GameTree (..), switch)

{- Ihre Aufgabe nun besteht darin, basierend auf einem bereits erzeugten GameTree
 - (siehe Aufgabe 18) den besten Zug und die damit verbundenen Gewinnaussichten
 - eines Spielers zu ermitteln. Fuer gegebenen Spieler und Spielbaum geben Sie also
 - die (bzw. eine beliebige, falls mehrere gleich gute Alternativen bestehen) Position
 - zurueck, auf die der Spieler setzen sollte, um den fuer sich (noch) bestmoeglichen
 - Spielausgang zu erreichen. Ausserdem geben Sie einen Wert zurueck, der angibt, was
 - dieser aus Sicht des sich am Zug befindlichen Spielers bestmoegliche noch erzwingbare
 - Spielausgang ist:
 -   -> Nothing, fuer Unentschieden
 -   -> Just player, fuer Sieg (wenn selbst player) oder Niederlage (wenn der andere)
 -}

-- 1. versuch zu blocken 2. gute position finden
bestMove :: (Player, GameTree) -> (Pos, Maybe Player)
bestMove (p, Draw) = Nothing
bestMove (p, Lost) = p
bestMove (p, Continue subTree) = bestMove (switch p) subTree




main = do
  let tree1 = Continue [((A,Z),Continue [((C,X),Continue [((C,Y),Draw)]),
                           ((C,Y),Continue [((C,X),Lost)])]),
          ((C,X),Lost),
          ((C,Y),Continue [((A,Z),Lost),
                           ((C,X),Continue [((A,Z),Draw)])])]
  let move1 = ((C,X), Just xPlayer)


  let tree2 = Continue [((C,X),Continue [((C,Y),Draw)]),
          ((C,Y),Continue [((C,X),Lost)])]
  let move2 = ((C,X), Nothing)

  print (bestMove tree1)
  print (bestMove tree2)



{- Sie koennen voraussetzen/verwenden, dass bestMove nur fuer Situationen aufgerufen
 - wird, in denen tatsaechlich noch Zuege moeglich sind. Die Faelle
 -
 -   bestMove (player, Lost)
 -   bestMove (player, Draw)
 -
 - brauchen Sie dann also nicht zu definieren.
 -
 - Beispiele:
 - ----------
 -
 -   1. Ist xPlayer am Zug und der aktuelle Spielbaum wie folgt:
 -
 -     Continue [((A,Z),Continue [((C,X),Continue [((C,Y),Draw)]),
 -                                ((C,Y),Continue [((C,X),Lost)])]),
 -               ((C,X),Lost),
 -               ((C,Y),Continue [((A,Z),Lost),
 -                                ((C,X),Continue [((A,Z),Draw)])])]
 -
 -   dann sollte bestMove das Paar ((C,X), Just xPlayer) zurueckliefern. Denn wenn
 -   xPlayer (C,X) spielt, dann waere danach oPlayer am Zug, hat aber verloren.
 -   Keiner der anderen beiden moeglichen Zuege fuer xPlayer ist gleich gut. Denn wenn
 -   xPlayer (A,Z) spielen wuerde, koennte oPlayer darauf mit (C,X) antworten, woraufhin
 -   xPlayer nur (C,Y) ziehen und somit nur ein Unentschieden erreichen koennte.
 -   Wenn xPlayer dagegen (C,Y) ziehen wuerde, dann koennte oPlayer mit (A,Z) antworten
 -   und xPlayer wuerde verlieren.
 -
 -   2. Ist xPlayer am Zug und der aktuelle Spielbaum wie folgt:
 -
 -     Continue [((C,X),Continue [((C,Y),Draw)]),
 -               ((C,Y),Continue [((C,X),Lost)])]
 -
 -   dann sollte bestMove das Paar ((C,X), Nothing) zurueckliefern, denn in dieser
 -   Situation ist ein Unentschieden das bestmoegliche Ergebnis fuer xPlayer.
 -   (Der Zug (C,Y) wuerde ja dazu fuehren, dass oPlayer nach dem naechsten Zug
 -   gewonnen hat.)
 -
 - Beachten Sie, dass auch Situationen moeglich sind, in denen der aktuelle Spieler
 - selbst bei bestmoeglicher Zugauswahl nur noch verlieren kann (sofern der Gegenspieler
 - optimal spielt). Geben Sie dann dennoch einen Zug zurueck, sowie innerhalb der
 - zweiten Tupelkomponente die Information, dass der Gegenspieler gewinnt.
 -
 - Auch wenn ein Unentschieden oder Sieg erzwingbar sind, kann es mehrere dahingehende
 - Zuege geben. Auch hier koennen Sie einen beliebigen davon zurueckgeben.
 -}
