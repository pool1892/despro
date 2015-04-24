module Main where
import Prelude

{-
 - Eine Block-Quersumme fasst jeweils mehrere Ziffern vor Summation
 - zusammen, bei der letzten Stelle beginnend. Zum Beispiel ist die
 - 3-Block-Quersumme von 1234567 die Zahl 1 + 234 + 567 = 802.
 - Eine alternierende Quersumme wechselt Addition und Subtraktion
 - ab, und zwar so, dass insgesamt keine negative Zahl entsteht.
 - Zum Beispiel ist die alternierende 3-Block-Quersumme von 1234567
 - die Zahl 1 - 234 + 567 = 334, waehrend sich die alternierende
 - 2-Block-Quersumme von 54321 als -5 + 43 - 21 = 17 ergibt.
 - 
 - Schreiben Sie eine Funktion, die so generalisierte Quersummen
 - von natuerlichen Zahlen berechnet. Die Funktion wird gesteuert
 - ueber Argumente fuer die Blocklaenge und (als Boolescher Wert)
 - fuer die Angabe, ob oder ob nicht alternierend gerechnet wird.
 - Also zum Beispiel:
 - 
 -   genQuer 3 False 1234567 = 802
 -   genQuer 3 True  1234567 = 334
 -   genQuer 2 True  54321   = 17
 -}

genQuer :: Integer -> Bool -> Integer -> Integer
genQuer 0 _ _ = 0
genQuer _ _ 0 = 0
genQuer t False n = sum(tolist t n)
genQuer t True n | sum[((- 1)^x)*((tolist t n)!!x) |x<-[0..(length(tolist t n)-1)]]>0 =sum[((- 1)^x)*((tolist t n)!!x) |x<-[0..(length(tolist t n)-1)]]
				 | otherwise =sum[((- 1)^(x+1))*((tolist t n)!!x) |x<-[0..(length(tolist t n)-1)]]	
	
tolist:: Integer -> Integer -> [Integer]
tolist t 0=[]
tolist t n=  (n `mod` 10^t):tolist t (n `div` 10^t) 


main=do
	print(genQuer 3 False 1234567)
