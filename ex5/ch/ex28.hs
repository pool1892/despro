module Blueprint where
import Prelude
import Data.List
import Data.Maybe
import Test.QuickCheck

{- Betrachten Sie wieder den folgenden Datentyp: -}

data Bit = O | I  deriving (Eq, Show)

{- und schreiben Sie Funktionen, um Werte im Sinne einer Serialisierung 
 - in eine Sequenz von Bits umzuwandeln und zurueck, diesmal jedoch nicht
 - nur fuer einen speziellen Ursprungstyp wie [Either Bool Bool] oder [[Bool]]
 - oder Tree mit Bool-Blaettern.
 -
 - Gehen Sie vielmehr von wie folgt deklarierten Typklassen aus:
 -}

class Encode a where
  encode :: a -> [Bit]

class Decode a where
  decode' :: [Bit] -> Maybe (a, [Bit])

{- Dabei ist fuer decode' bewusst ein Interface gewaehlt, das etwas
 - allgemeiner ist als das von decode. Die Idee ist (wieder), dass decode'
 - nur ein Anfangsstueck (so weit wie moeglich) der Eingabeliste 
 - umwandelt, und einen eventuell nicht verbrauchten Rest zurueckliefert. 
 - 
 - Es soll also gelten, dass wenn
 - 
 -   decode' c = Just (v, c')
 - 
 - dann
 - 
 -   encode v ++ c' = c
 -
 - Die Funktion decode selbst ist wie folgt definiert:
 -}

decode :: Decode a => [Bit] -> Maybe a
decode c = case decode' c of
             Just (v, []) -> Just v
             _            -> Nothing

{- Ergaenzen Sie unten die fehlenden Typklasseninstanzen (jeweils nach
 - Entfernen der Kommentarzeichen).
 -
 - Beachten Sie, dass es *nicht* noetig ist, irgendwelche Typinformationen
 - in den Bitstring zu kodieren (also etwa mittels encode False = [I,O],
 - encode True = [I,I], um durch das erste "I" die Typinformation "Bool" zu
 - signalisieren, und "O" oder andere Praefixe fuer Either, Listen etc. zu
 - verwenden). Der Typklassenmechanismus selbst genuegt voellig, um bei
 - Aufrufen von decode an Hand des gewuenschten Resultattyps das
 - "Dispatching" zur passenden Implementierung zu leisten.
 -
 - Beachten Sie auch, dass Sie innerhalb der Instanzen fuer Decode eher
 - *nicht* decode, sondern hoechstens wieder decode' aufrufen wollen (sollten).
 -}

instance Encode Bool where
  encode False = [O]
  encode True  = [I]

-- instance Decode Bool where
--   ...

-- instance (Encode a, Encode b) => Encode (Either a b) where
--   ...

-- instance (Decode a, Decode b) => Decode (Either a b) where
--   ...

instance Encode a => Encode [a] where
  encode []     = [O]
  encode (a:as) = I : encode a ++ encode as

-- instance Decode a => Decode [a] where
--   ...

data Tree a = Leaf a | Node (Tree a) (Tree a)  deriving (Eq, Show)

-- instance Encode a => Encode (Tree a) where
--   ...

-- instance Decode a => Decode (Tree a) where
--   ...

{- Insgesamt soll die dem folgenden Test entsprechende allgemeine Aussage 
 - gelten:
 -}

test1 :: (Encode a, Decode a, Eq a) => a -> Bool
test1 v = decode (encode v) == Just v

{- und zwar fuer Werte (v) jeden Typs, der sich aus Bool, Either, Tree und 
 - Listen zusammensetzen laesst. Fuer jeden dieser Typen sollen ebenso 
 - "Varianten" der Umkehrung dieser Aussage gelten, also etwa: 
 -}

test2 :: [Bit] -> Property
test2 c = let mv = decode c :: Maybe [Either Bool Bool]
          in isJust mv
             ==> encode (fromJust mv) == c

test3 :: [Bit] -> Property
test3 c = let mv = decode c :: Maybe [[Bool]]
          in isJust mv
             ==> encode (fromJust mv) == c

test4 :: [Bit] -> Property
test4 c = let mv = decode c :: Maybe (Tree [Bool])
          in isJust mv
             ==> encode (fromJust mv) == c

{- Die Testsuite koennte also zum Beispiel so aussehen: -}

main = sequence_ [ quickCheck (test1 :: [Either Bool Bool] -> Bool)
                 , quickCheck (test1 :: [[Bool]] -> Bool)
                 , quickCheck (test1 :: Tree [Bool] -> Bool)
                 , quickCheckWith (stdArgs {maxSuccess=10}) test2 
                 , quickCheckWith (stdArgs {maxSuccess=10}) test3 
                 , quickCheckWith (stdArgs {maxSuccess=10}) test4
                 , quickCheck $ \c -> let mv = decode' c :: Maybe ([[Bool]], [Bit])
                                      in isJust mv
                                         ==> case mv of 
                                               Just (v, c') -> encode v ++ c' == c]

{- Folgende Typklasseninstanzen werden wieder nur benoetigt, um QuickCheck auf
 - die Spruenge zu helfen:
 -}

instance Arbitrary Bit where
  arbitrary = elements [O,I]

instance Arbitrary a => Arbitrary (Tree a) where
   arbitrary = sized treegen
     where treegen n | n <= 1 = fmap Leaf arbitrary
           treegen n          = do i <- elements [0 .. n-1]
                                   l <- treegen i
                                   r <- treegen (n-1-i)
                                   return (Node l r)
