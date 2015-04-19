module Blueprint where
import Prelude

{- 
 - Schreiben Sie eine Funktion 'prod', die das Produkt einer Liste von Zahlen
 - berechnet, so dass zum Beispiel gilt: prod [2,5,3] = 30.
 - 
 - Verwenden Sie 'head', 'tail' und die vordefinierte Funktion 'null', welche
 - eine Liste auf Leerheit testet (also null [] = True, ansonsten False).
 - Explizit: verwenden Sie kein Pattern Matching oder andere Mittel.
 -}

prod :: [Integer] -> Integer
prod ns 
    |null ns =1
    |otherwise = head ns * prod (tail ns)