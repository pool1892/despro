-- module Blueprint where
-- import Prelude hiding (IO(..), getChar, getLine, readLn, 
--                        putChar, putStr, putStrLn, print)
-- import Test.IOSpec
-- import IOTestHelper
-- type IO = IOSpec Teletype

{- Schreiben Sie ein Programm, das solange (auch negative) ganze Zahlen einliest,
 - bis sich die zwei zuletzt eingegebenen Zahlen zu Null summieren. Nach vollstaendig 
 - beendeter Eingabe soll das Programm die Anzahl derjenigen eingegebenen Zahlen 
 - ausgeben, welche groesser Null und durch drei teilbar sind. (Dabei sollen auch die 
 - beiden letzten Eingaben mit beruecksichtigt werden.)
 - 
 - Beachten Sie, dass Ihr Programm immer mindestens zwei Zahlen einlesen muss bevor es 
 - terminieren kann.
 -   
 - Ein Beispiel: fuer die Eingaben 4, 3, -3 ist die korrekte Ausgabe 1. Denn das 
 - Programm bricht ab, da 3 + (-3) = 0; und die Ausgabe ist 1, da allein 3 als positive 
 - durch drei teilbare Zahl eingegeben wurde.
 - 
 - Als IO-Primitiven stehen Ihnen die oben aufgelisteten (sowie return) zur Verfuegung.
 - Zum Ausprobieren Ihrer Loesung ausserhalb Autotools entfernen Sie einfach die obigen 
 - Zeilen komplett.
 -}
-- && (letzter == -(toInteger temp) )
main :: IO ()
main = reading 1 0 1


reading::Integer -> Integer -> Integer -> IO()
reading durchlauf anzahl letzter 
    = do 
        putStrLn $ "Dies ist Durchlauf "++ show durchlauf
        putStrLn "Eingabe bitte: "
        temp<- getLine
        let n = read temp
        let p = durchlauf>1  && letzter == -n  
        let q = n > 0 && n `mod`3==0
        putStrLn $ show temp ++ ", danke sehr!"
        if p
            then do putStrLn "Die letzten beiden Zahlen canceln."
                    if q
                        then  putStrLn $ "Die Anzahl der positiven durch 3 teilbaren Zahlen war " ++ show(anzahl+1)
                        else putStrLn $ "Die Anzahl der positiven durch 3 teilbaren Zahlen war " ++ show anzahl
            else if q
                    then  reading (durchlauf+1) (anzahl+1) n
                    else  reading (durchlauf+1) anzahl n
