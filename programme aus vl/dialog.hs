dialog k
       = do putStr $ show k ++ ". Eingabe: "
            s <- getLine
            if s == "end" 
              then putStrLn $ "Es wurden " ++ show (k-1) ++ " Zahlen quadriert"
              else do let n = read s
                      putStrLn ("Ausgabe: " ++ show (n*n))
                      dialog (k+1)

main = dialog 1
