{-Schreiben Sie ein Programm, das mittels Gloss eine horizontale Reihe von sich beru ̈hrenden Kreisen gegebener Proportionen darstellt. 
Definieren Sie dazu eine Funktion, die eine Liste von Kreisgro ̈ßen auf ein Picture abbildet.

Es darf angenommen werden, dass die Gro ̈ßen positive Zahlen sind. 
Eine Beispielausgabe findet sich in Abbildung 1, wobei Sie die Kreise nicht mit Zahlwerten beschriften mu ̈ssen. 
Ihre Abgabe soll folgende Szene darstellen (geeignet skaliert, um nicht allzu pixelige Ausgaben zu erhalten), 
aber mit jeder beliebigen Liste funktionieren.-}
module Main (main) where

import Graphics.Gloss

main = display (InWindow "" (900, 400) (100,200)) white scene

pearlnecklace :: [Float] -> Picture
pearlnecklace xs | xs==[]  = blank
				 | length xs ==1 = pictures [translate ((head xs)*0) 0 (circle ((head xs)*20))] 
			   	 | otherwise = pictures $ [circle(head(xs)*20)] ++ [translate (((head xs)+ head(tail(xs)) )*20) 0 (pearlnecklace (tail xs))]


scene :: Picture
scene = pearlnecklace [ 3, 1, 4, 2 ]

