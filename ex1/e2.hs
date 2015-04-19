module Blueprint where
import Prelude

{-
 - Schreiben Sie (selbst) zwei syntaktisch deutlich verschiedene Varianten einer
 - Funktion 'sgn', die fuer eine gegebene Zahl deren Signum (also: 1, 0 oder -1)
 - liefert. Experimentieren Sie zum Beispiel mit explizitem if-then-else, mit
 - Konstanten in Parameterpositionen wie bei fac und ack, mit Guards, ...
 - (Erhalten Sie dabei die Reihenfolge der Funktionen und die Typsignaturen.)
 -}

sgn1 :: Int -> Int
sgn1 n 
    |n==0 =0
    |n>0   =1
    |n<0   = - 1

sgn2 :: Int -> Int
sgn2 n = if n==0 then 0 else if n<0 then -1 else 1
