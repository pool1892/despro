module Blueprint where
import Prelude
import MParserCore -- noch in der ParserCore-Variante
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser zur Erkennung einer genau festgelegten
 - Zeichenkette: 
 -}

exactly :: String -> Parser ()
exactly "" = yield ()
exactly s = do char (head s)
               exactly (tail s)
               return ()

{- Es soll also gelten, dass 'exactly s' genau die Eingabe s akzeptiert. -}

test s = parse (exactly s) s == ()

{- hlint:
 - No suggestions
 -}