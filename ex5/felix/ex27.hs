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
             a1 <- many bitlist'
             a2 <- many (char ',' +++ bitlist')
             char ']'
             case (a1, a2) of
                ([], xs) -> failure
                (x:y:xs, _) -> failure
                ([], []) -> return (a1 ++ a2)
                (_, _) -> return (a1 ++ a2)

bitlist' = do many (char ' ')
              c <- item
              many (char ' ')
              charToBit c

charToBit :: Char -> Parser Bit
charToBit 'O' = return O
charToBit 'I' = return I
charToBit _ = failure

{- Allerdings sollen um die Listenelemente herum auch Leerzeichen erlaubt sein,
 - also zum Beispiel auch "[ O ,I ]" korrekt erkannt werden.
 -}
