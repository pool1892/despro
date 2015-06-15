<<<<<<< Updated upstream
module LParserCore where

type Parser a = String -> [(a, String)]

parse :: Parser a -> String -> [a]
parse p inp = [ x | (x, rest) <- p inp, rest == ""]

item :: Parser Char
item inp = case inp of
             ""   -> []
             x:xs -> [(x,xs)]

infixr 3 |||

(|||) :: Parser a -> Parser a -> Parser a
(p ||| q) inp = p inp ++ q inp

failure :: Parser a
failure _ = []

infixr 4 ++>

(++>) :: Parser a -> (a -> Parser b) -> Parser b
(p ++> f) inp = concatMap (\(x, rest) -> f x rest) (p inp)

yield :: a -> Parser a
yield x inp = [(x, inp)]
=======
module LParserCore where

type Parser a = String -> [(a, String)]

parse :: Parser a -> String -> [a]
parse p inp = [ x | (x, rest) <- p inp, rest == ""]

item :: Parser Char
item inp = case inp of
             ""   -> []
             x:xs -> [(x,xs)]

infixr 3 |||

(|||) :: Parser a -> Parser a -> Parser a
(p ||| q) inp = p inp ++ q inp

failure :: Parser a
failure _ = []

infixr 4 ++>

(++>) :: Parser a -> (a -> Parser b) -> Parser b
(p ++> f) inp = concatMap (\(x, rest) -> f x rest) (p inp)

yield :: a -> Parser a
yield x inp = [(x, inp)]
>>>>>>> Stashed changes
