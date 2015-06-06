module Blueprint where
import Prelude
import MParserCore -- in der LParserCore-Variante
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser, der Palindrome beschreibt/erkennt. -}

palindrome :: Parser ()
palindrome = yield() ||| item +++ yield() ||| 
             do c <- item 
                palindrome
                x <- item
                if x == c then yield() else failure


{- Fuer QuickCheck-Testen: -}

test1 = forAll validInputs $ \s -> not (null (parse palindrome s))

test2 = forAll invalidInputs $ \s -> null (parse palindrome s)

validInputs :: Gen String
validInputs = do s <- listOf (elements "ABC123")
                 b <- arbitrary
                 if b || null s
                   then return (s ++ reverse s)
                   else return (s ++ tail (reverse s))

invalidInputs :: Gen String
invalidInputs = do n <- growingElements [2..100]
                   s <- vectorOf n (elements "ABC123")
                   if s == reverse s
                     then invalidInputs
                     else return s

{- hlint:
 - No suggestions
 -}