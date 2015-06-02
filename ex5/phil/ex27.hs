module Blueprint where
import Prelude
import MParserCore -- ruhig schon in der LParserCore-Variante
import Parser
import Test.QuickCheck

{- Gegeben sei: -}

data Bit = O | I  deriving (Read, Show, Eq)

{- Schreiben Sie einen Parser fuer Listen (in Haskell-Notation) des
 - Typs [Bit]:
 -}

bitlist :: Parser [Bit]
bitlist = do char '['
             a1 <- many b
             a2 <- many (char ',' +++ b)
             char ']'
             case (a1, a2) of
                ([], []) -> return (a1 ++ a2)
                (x:y:xs, _) -> failure
                ([], xs) -> failure
                (_, _) -> return (a1 ++ a2)
          where b = do many (char ' ')
                       c <- item
                       many (char ' ')
                       cToBit c

cToBit :: Char -> Parser Bit
cToBit 'O' = return O
cToBit 'I' = return I
cToBit _ = failure

{- Allerdings sollen um die Listenelemente herum auch Leerzeichen erlaubt sein,
 - also zum Beispiel auch "[ O ,I ]" korrekt erkannt werden.
 -}
