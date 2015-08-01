module Blueprint where
import Prelude
import MParserCore hiding ((++>)) -- in der LParserCore-Variante
import Parser
import Test.QuickCheck

{- Schreiben Sie einen Parser, der Palindrome beschreibt/erkennt, die aus
 - Kleinbuchstaben (des englischen Alphabets) bestehen.
 -}

test x _ y = if x==y then yield () else failure

palindrome :: Parser ()
palindrome = yield () |||
             item +++ yield () |||
             test <$> lower *> palindrome <* lower


{-
palindrome = yield () |||
             item +++ yield () |||
             do x <- item
                palindrome
                y <- item
                satP (x==y)
-}

{- Beachten Sie dass die Verwendung von ++> ausgeschlossen ist, ebenso die
 - Verwendung von do-Notation oder >>= und return!
 - Zur Verfuegung stehen jedoch pure, (<*>), (<*), (*>), (<$>), (<$).
 -}

{- Fuer QuickCheck-Testen: -}

test1 = forAll validInputs $ \s -> not (null (parse palindrome s))

test2 = forAll invalidInputs $ \s -> null (parse palindrome s)

validInputs :: Gen String
validInputs = do s <- listOf (elements ['a'..'z'])
                 b <- arbitrary
                 if b || null s
                   then return (s ++ reverse s)
                   else return (s ++ tail (reverse s))

invalidInputs :: Gen String
invalidInputs = do n <- growingElements [2..100]
                   s <- vectorOf n (elements ['a'..'z'])
                   if s == reverse s
                     then invalidInputs
                     else return s


main = do
  print $ parse palindrome "a"
  quickCheck test1
  -- quickCheck test2
