module Blueprint where
import Prelude
import MParserCore -- ruhig schon in der LParserCore-Variante
import Parser

{- Gegeben sei: -}

data Bit = O | I  deriving (Read, Show, Eq)

{- Schreiben Sie einen Parser fuer Listen (in Haskell-Notation) des
 - Typs [Bit]:
 -}

bitlist :: Parser [Bit]
bitlist = do char '['
             res1 <- many bitlistHelper
             res2 <- many (char ',' +++ bitlistHelper)
             char ']'
             case (res1, res2) of
                ([], []) -> return (res1 ++ res2)
                ([], xs) -> failure
                (x:y:xs, _) -> failure
                (_, _) -> return (res1 ++ res2)

bitlistHelper :: Parser Bit
bitlistHelper = do many (char ' ')
                   c <- item
                   many (char ' ')
                   case c of
                        'I' -> return I
                        'O' -> return O
                        _ -> failure
{-
bitlist :: Parser [Bit]
bitlist = do char '['
             res2 <- many (bitlistHelper ++> \y -> (char ',' +++ yield y))
             res1 <- bitlistHelper
             char ']'
             return (res2 ++ [res1])

bitlistHelper :: Parser Bit
bitlistHelper = do many (char ' ')
                   c <- item
                   many (char ' ')
                   case c of
                        'I' -> return I
                        'O' -> return O
                        _ -> failure
-}
{-
bitlist :: Parser [Bit]
bitlist = do char '['
             res1 <- bitlistHelper
             res2 <- many (char ',' +++ bitlistHelper)
             char ']'
             return (res1 : res2)

bitlistHelper :: Parser Bit
bitlistHelper = do many (char ' ')
                   c <- item
                   many (char ' ')
                   case c of
                        'I' -> return I
                        'O' -> return O
                        _ -> failure
-}
{- Allerdings sollen um die Listenelemente herum auch Leerzeichen erlaubt sein,
 - also zum Beispiel auch "[ O ,I ]" korrekt erkannt werden.
 -}
 
{- hlint:
 - No suggestions
 -}