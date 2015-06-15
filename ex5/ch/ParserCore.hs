module ParserCore where

type Parser a = String -> Maybe (a, String)

parse :: Parser a -> String -> a
parse p inp = case p inp of 
                Nothing        -> error "invalid input"
                Just (x, "")   -> x
                Just (_, rest) -> error ("unused input: " ++ rest)

item :: Parser Char
item inp = case inp of
             ""   -> Nothing
             x:xs -> Just (x,xs)

infixr 3 |||

(|||) :: Parser a -> Parser a -> Parser a
(p ||| q) inp = case p inp of
                  Just (x, rest) -> Just (x, rest)
                  Nothing        -> q inp

failure :: Parser a
failure _ = Nothing

infixr 4 ++>

(++>) :: Parser a -> (a -> Parser b) -> Parser b
(p ++> f) inp = case p inp of
                  Nothing        -> Nothing
                  Just (x, rest) -> f x rest

yield :: a -> Parser a
yield x inp = Just (x, inp)
