main :: IO ()
main = scan 1 0 1

scan::Integer -> Integer -> Integer -> IO()
scan run count list = do
    putStrLn $ "#" ++ show run ++ ": Enter Number, then press enter "
    t <- getLine
    let x = read t
        b = x > 0 && x `mod`3 == 0
        c = if b then count+1 else count
    if run > 1  && list == -x
      then putStrLn $ "Done. Anzahl der positiven durch 3 teilbaren Zahlen: " ++ show c
      else scan (run+1) c x


