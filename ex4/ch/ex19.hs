module Blueprint where
import Prelude
import Data.Maybe
import Test.QuickCheck

{- Betrachten Sie folgende Datentypen: -}

data Bit = O | I  deriving (Eq, Show)

data Tree = Leaf Bool | Node Tree Tree  deriving (Eq, Show)

{- und schreiben Sie zu folgender Funktion: -}

encode :: Tree -> [Bit]
encode (Leaf b)   = [O, bool2bit b]
encode (Node l r) = I : encode l ++ encode r

bool2bit :: Bool -> Bit
bool2bit False = O
bool2bit True  = I

{- eine Funktion: -}

decode :: [Bit] -> Maybe Tree
decode = undefined

{- welche aus jeder Liste des Typs [Bit], die mittels encode erzeugt
 - werden kann, einen Wert 'Just t' macht, wobei t gerade der Ursprungs-
 - baum vor Anwendung von encode ist. Die Funktion decode soll genau
 - dann den Wert 'Nothing' liefern, wenn fuer die gegebene [Bit]-Liste
 - kein entsprechender Ursprungsbaum des Typs Tree existiert.
 -
 - HINWEIS: Am besten implementieren Sie eine Hilfsfunktion
 - 
 -   decode' :: [Bit] -> Maybe (Tree, [Bit])
 - 
 - welche nur ein Anfangsstueck (so weit wie moeglich) der Eingabeliste
 - umwandelt, und einen nicht verbrauchten Rest zurueckliefert. Die Idee
 - ist also, dass wenn 
 - 
 -   decode' c = Just (v, c')
 - 
 - dann
 - 
 -   encode v ++ c' = c
 - 
 - (und decode wird mittels decode' definiert).
 -
 - Zum Beispiel liefert dann decode' [I,O,O,O,I,O,I] den Wert
 - 
 -   Just (Node (Leaf False) (Leaf True), [O,I])
 -
 - denn es gilt ja
 -
 -   encode (Node (Leaf False) (Leaf True)) = [I,O,O,O,I]
 -
 - Und decode' [I,O,I,O,O] liefert den Wert
 -
 -   Just (Node (Leaf True) (Leaf False), [])
 -
 - "ohne Rest", also decode [I,O,I,O,O] einfach den Wert
 -
 -   Just (Node (Leaf True) (Leaf False))
 -}

{- Insgesamt sollen wieder die den folgenden beiden Tests entsprechenden
 - allgemeinen Aussagen gelten:
 -  
 - (lokal aufzurufen als "quickCheck test1" bzw. "quickCheck test2")
 -}

test1 v = decode (encode v) == Just v

test2 c = let mv = decode c 
          in isJust mv
             ==> encode (fromJust mv) == c

{- Folgende Typklasseninstanzen werden nur benoetigt, um QuickCheck auf
 - die Spruenge zu helfen:
 -}

instance Arbitrary Bit where
  arbitrary = elements [O,I]

instance Arbitrary Tree where
   arbitrary = sized treegen
     where treegen n | n <= 1 = fmap Leaf arbitrary
           treegen n          = do i <- elements [0 .. n-1]
                                   l <- treegen i
                                   r <- treegen (n-1-i)
                                   return (Node l r)
