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
s = pure () ||| check 'a' 'b' ||| check 'b' 'a'

check x y = char x *> s <* char y *> s

{- Beachten Sie dass die Verwendung von ++> ausgeschlossen ist, ebenso die
 - Verwendung von do-Notation oder >>= und return!
 - Zur Verfuegung stehen jedoch pure, (<*>), (<*), (*>), (<$>), (<$).
 -}

-- main = show (parse "abbabaabba")
