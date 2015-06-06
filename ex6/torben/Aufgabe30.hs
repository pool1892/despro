module Blueprint where
import Prelude
import MParserCore hiding ((++>)) -- in der LParserCore-Variante
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser zur Erkennung genau der Zeichenketten (wie "abbabaabba")
 - in denen nur, und gleich viele, a und b vorkommen. Folgen Sie dabei dem 
 - Syntaxdiagramm aus dem Aufgabenblatt.
 -}

s :: Parser ()
s = (char 'a' *> s <* char 'b' *> s) ||| (char 'b' *> s <* char 'a' *> s) ||| pure()

{- Beachten Sie dass die Verwendung von ++> ausgeschlossen ist, ebenso die 
 - Verwendung von do-Notation oder >>= und return!
 - Zur Verfuegung stehen jedoch pure, (<*>), (<*), (*>), (<$>), (<$). 
 -}

{- hlint:
 - No suggestions
 -}