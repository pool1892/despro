{-
Ausgabevergleich von nub und elems
Gleiche Ausgabe: 
    1. Eingabe Typ [Int]
    2. Reihenfolge des ersten Auftretens der Zahlen = Reihenfolge des letzten Auftretens der Zahlen

Ungleiche Ausgabe:
    Fall1: Eingabe ist eine unendliche Liste.
    Fall2: Wenn 2. von "Gleiche Ausgabe" nicht erfuellt ist.
           Da elems die Liste von hinten nach vorne durchgeht und nubs scheinbar von vorne nach hinten, ist
           diese Bedingung notwendig.
-}
module Blueprint where
import Data.List
import Test.QuickCheck

elems :: [Int] -> [Int]
elems xs = foldr (\x ys -> if elemHelper x ys then ys else x : ys) [] xs

elemHelper :: Int -> [Int] -> Bool
elemHelper x xs = foldr (\y b -> x == y || b) False xs

-- f dreht die Eingabe um, sodass nub nun (wie elems) "von hinten nach vorne" durchgeht
f :: [Int] -> [Int]
f = reverse

{- Da nub neue Elemente hinten an die Ausgabeliste anhaengt (und nicht vorne wie elems),
 - muss die Ausgabeliste ebenfalls umgedreht werden.
 -}
g :: [Int] -> [Int]
g = f

{- Alternative (geschummelt und sicherlich nicht im Sinne des Aufgabenstellers):
 - f :: [Int] -> [Int]
 - f xs = xs
 - 
 - g :: [Int] -> [Int]
 - g = elems
 -}

test1 xs = elems xs == (f.nub.g) xs