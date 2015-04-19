module Blueprint where
import Prelude
{-
 - Geben Sie eine Haskell-Spezifikation zur Ermittlung des kleinsten
 - gemeinsamen Vielfachen zweier natuerlicher Zahlen an.
 - (Erhalten Sie dabei die Typsignatur.)
 -}

kgv :: Int -> Int -> Int
kgv n m 
    |n==0||m==0=0
    |otherwise =minimum [z|z<-[1..m*n],z`mod`n==0,z`mod`m==0    ] 
