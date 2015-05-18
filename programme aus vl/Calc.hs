import MParserCore
import Parser
import Data.Char

data Expr = Lit Int | Add Expr Expr | Mul Expr Expr  deriving (Read, Show)
           
expr :: Parser Expr
expr = liftP Add term (char '+' +++ expr) ||| term

term :: Parser Expr
term = do f <- factor
          char '*'
          t <- term
          return (Mul f t)
       ||| factor

factor :: Parser Expr
factor = mapP Lit nat
         ||| char '(' +++ expr ++> \e -> char ')' +++ yield e

nat :: Parser Int
nat = mapP (foldl (\n d -> 10 * n + d) 0) (many1 (mapP digitToInt digit))

eval :: Expr -> Int
eval (Lit n)     = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2

calc :: String -> Int
calc s = eval (parse expr s)
