import System.Random

data Task = Sub Int Int | Add Int Int

instance Show Task where
  show (Sub x y) = show x ++ " - " ++ show y ++ " = _________"
  show (Add x y) = show x ++ " + " ++ show y ++ " = _________"

generate g = [ if f then Sub a b else Add a b
             | (a,b,f) <- zip3 as bs fs,
               if f then a-b >= 0 else a+b < 100]
  where as = randomRs (0,99) g1
        bs = randomRs (0,99) g3
        fs = randoms g4
        (g1,g2) = split g
        (g3,g4) = split g2

main = do g <- getStdGen
          run $ take 20 (generate g)

run :: [Task] -> IO [Task]
run = while (not . null) $
      \ts -> do let t = head ts
                print t
                r <- readLn
                if check t r then putStrLn "Richtig!" else putStrLn "Falsch!"
                return (tail ts)

check :: Task -> Int -> Bool
check (Sub x y) r = x-y == r
check (Add x y) r = x+y == r

while :: (a -> Bool) -> (a -> IO a) -> a -> IO a
while p body = loop
  where loop x = if p x then do x' <- body x
                                loop x'
                        else return x
