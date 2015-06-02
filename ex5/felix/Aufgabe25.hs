module Aufgabe25 where
import Prelude
import MParserCore
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser zur Erkennung einer genau festgelegten
 - Zeichenkette:
 -}

exactly :: String -> Parser ()
exactly "" = yield ()
exactly str = do char (head str)
                 exactly (tail str)
                 return ()

{- Es soll also gelten, dass 'exactly s' genau die Eingabe s akzeptiert. -}

-- test s = parse (exactly s) s == ()
