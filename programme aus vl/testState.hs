import Control.Monad.State

test :: State Integer (Integer,Integer)
test = do x <- get
          put (x+1)
          y <- f
          z <- get
          return (y,z)

f :: State Integer Integer
f = do u <- get
       put 0
       return u

run = evalState test 5
