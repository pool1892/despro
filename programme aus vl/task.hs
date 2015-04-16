import System.Random

data Task = Sub Int Int | Add Int Int

instance Show Task where
  show (Sub x y) = show x ++ " - " ++ show y ++ " = _________"
  show (Add x y) = show x ++ " + " ++ show y ++ " = _________"

generate g = [ if f then Sub a b else Add a b
             | (a,b,f) <- zip3 as bs fs,
               if f then a-b >= 0 else a+b < 100]
  where  as = randomRs (0,99) g1
         bs = randomRs (0,99) g3
         fs = randoms g4
         (g1,g2) = split g
         (g3,g4) = split g2

main = do  g <- getStdGen
           putStr . unlines . map show $ take 20 (generate g)
