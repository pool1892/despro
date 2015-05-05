module Blueprint where
import Prelude
import Data.Maybe
import Test.QuickCheck

{- Betrachten Sie folgenden Datentyp: -}

data Bit = O | I  deriving (Eq, Show)

{- und schreiben Sie Funktionen, um Werte des Typs [Either Bool Bool]
 - im Sinne einer Serialisierung in eine Sequenz von Bits umzuwandeln
 - und zurueck.
 -
 - Das heisst, schreiben Sie eine *injektive* Funktion:
 -}

encode :: [Either Bool Bool] -> [Bit]
encode [] = []
encode (x:xs) | (Left True == x)= O:I:encode xs
encode (x:xs) | (Left False == x)= O:O:encode xs
encode (x:xs) | (Right True == x)= I:I:encode xs
encode (x:xs) | (Right False == x)= I:O:encode xs
{- welche aus jeder Liste des Typs [Either Bool Bool] eine Liste des
 - Typs [Bit] macht, sowie eine Funktion:
 -}

decode :: [Bit] -> Maybe [Either Bool Bool]
decode []=Just []
decode xs |length (xs) `mod`2/=0 = Nothing
decode xs = Just (decodePair xs)

decodePair:: [Bit] -> [Either Bool Bool]
decodePair []= []
decodePair (O:O:xs) = Left False : decodePair xs
decodePair (O:I:xs) = Left True : decodePair xs
decodePair (I:I:xs) = Right True : decodePair xs
decodePair (I:O:xs) = Right False : decodePair xs

{- welche aus jeder Liste des Typs [Bit], die mittels encode erzeugt
 - werden kann, einen Wert 'Just l' macht, wobei l gerade die Ursprungs-
 - liste vor Anwendung von encode ist. Die Funktion decode soll genau
 - dann den Wert 'Nothing' liefern, wenn fuer die gegebene [Bit]-Liste
 - keine entsprechende Ursprungsliste des Typs [Either Bool Bool]
 - existiert.
 -
 - Mit anderen Worten, die den folgenden beiden Tests entsprechenden
 - allgemeinen Aussagen sollen gelten:
 -  
 - (lokal aufzurufen als "quickCheck test1" bzw. "quickCheck test2")
 -}

test1 v = decode (encode v) == Just v

test2 c = let mv = decode c 
           in isJust mv
               ==> encode (fromJust mv) == c

{- Folgende Typklasseninstanz wird nur benoetigt, um QuickCheck auf
 - die Spruenge zu helfen:
 -}

instance Arbitrary Bit where
  arbitrary = elements [O,I]
