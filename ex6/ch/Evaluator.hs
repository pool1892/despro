data Expr = Lit Int | Add Expr Expr | Mul Expr Expr | Sub Expr Expr | Div Expr Expr

eval :: Expr -> Either String Int
eval (Lit n)     = Right n
eval (Add e1 e2) = do r1 <- eval e1
                      r2 <- eval e2
                      return (r1+r2)
eval (Mul e1 e2) = do r1 <- eval e1
                      r2 <- eval e2
                      return (r1*r2)
eval (Sub e1 e2) = do r1 <- eval e1
                      r2 <- eval e2
                      return (r1-r2)
eval (Div e1 e2) = do r1 <- eval e1
                      r2 <- eval e2
                      if r2==0 then Left "div durch 0" else return (r1 `div` r2)
