module Blueprint where
import Prelude
import MParserCore
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser zur Erkennung einer genau festgelegten
 - Zeichenkette: 
 -}

exactly :: String -> Parser ()
exactly = undefined

{- Es soll also gelten, dass 'exactly s' genau die Eingabe s akzeptiert. -}

test s = parse (exactly s) s == ()
