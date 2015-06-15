module Blueprint where
import Prelude
import MParserCore hiding ((++>)) -- in der LParserCore-Variante
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser zur Erkennung genau der Zeichenketten (wie "abbabaabba")
<<<<<<< Updated upstream
 - in denen nur, und gleich viele, a und b vorkommen. Folgen Sie dabei dem
=======
 - in denen nur, und gleich viele, a und b vorkommen. Folgen Sie dabei dem 
>>>>>>> Stashed changes
 - Syntaxdiagramm aus dem Aufgabenblatt.
 -}

s :: Parser ()
s = undefined

<<<<<<< Updated upstream
{- Beachten Sie dass die Verwendung von ++> ausgeschlossen ist, ebenso die
 - Verwendung von do-Notation oder >>= und return!
 - Zur Verfuegung stehen jedoch pure, (<*>), (<*), (*>), (<$>), (<$).
=======
{- Beachten Sie dass die Verwendung von ++> ausgeschlossen ist, ebenso die 
 - Verwendung von do-Notation oder >>= und return!
 - Zur Verfuegung stehen jedoch pure, (<*>), (<*), (*>), (<$>), (<$). 
>>>>>>> Stashed changes
 -}
