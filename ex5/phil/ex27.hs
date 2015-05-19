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
bitlist = undefined

{- Allerdings sollen um die Listenelemente herum auch Leerzeichen erlaubt sein,
 - also zum Beispiel auch "[ O ,I ]" korrekt erkannt werden.
 -}
