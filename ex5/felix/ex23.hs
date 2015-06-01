module Blueprint where
import Data.List
import Test.QuickCheck

elems :: [Int] -> [Int]
elems = foldr (\x ys -> if elem' x ys then ys else x : ys) []

elem' :: Int -> [Int] -> Bool
elem' x = foldr (\y b -> x == y || b) False


-- Zu welchen Vergleichen, und in welcher Reihenfolge, mittels == führt der Aufruf
-- elem's [1,2,3,3,4,5,5,6] ?

-- elem' 6 [] -> kein vergleich
-- elem' 5 [6] -> 5==6
-- elem' 5 [5, 6] -> 5==6, 5==6
-- elem' 4 [5, 6] -> 4==6, 4==5
-- elem' 3 [4, 5, 6] -> 3==6, 3==5, 3==4
-- elem' 3 [3, 4, 5, 6] -> 3==6, 3==5, 3==4, 3==3
-- elem' 2 [3, 4, 5, 6] -> 2==6, 2==5, 2==4, 2==3
-- elem' 1 [2, 3, 4, 5, 6] -> 1==6, 1==5, 1==4, 1==3, 1==22

-- (b) Finden Sie systematisch heraus, fu ̈r welche Eingaben die Funktion elems gleiche Ausga- belisten wie die vordefinierte Funktion nub erzeugt (import Data.List), und fu ̈r welche Eingaben (mit Typ [Int]) unterschiedliches Verhalten vorliegt.
-- Geben Sie Funktionen f und g an, so dass elems = f . nub . g (auf Typ [Int]). Schreiben Sie einen QuickCheck-Test, der Ihre Behauptung besta ̈tigt.

-- Keine Duplikate -> Gleiches Ergebnis
-- Duplikate direkt aufeinander folgend -> Gleiches Ergebnis
-- Alle anderen Fälle verschieden
-- Begründung: nub arbeitet von links aus, elems von rechts aus.
-- Also ist bei allen Listen, bei denen Duplikate nicht direkt aufeinander folgen,
-- die Reihenfolge bezüglich dieses Elementes vertauscht.
-- Bsp.: [2,1,2,3] -> nub: [2,1,3], elems: [1,2,3]
-- und:  [2,2,1,3] -> nub: [2,1,3], elems: [2,1,3]


-- Geben Sie Funktionen f und g an, so dass elems = f . nub . g (auf Typ [Int]). Schreiben Sie einen QuickCheck-Test, der Ihre Behauptung besta ̈tigt.

f, g :: [Int] -> [Int]
f = reverse
g = reverse

leTest xs = elems xs == (f.nub.g) xs

main = quickCheck leTest


