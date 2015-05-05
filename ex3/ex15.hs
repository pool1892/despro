module Main (main) where
import Prelude
import Graphics.Gloss

main =  display (InWindow "" (600, 600) (0,0)) white scene



scene :: Picture
scene = grid 3 180 numbers


grid:: Int -> Float -> [Picture] -> Picture
grid columns distance ps = translate (-200) 100 (draw distance (rows columns ps))



rows ::Int->[a]->[[a]] 
rows n l | length l<n = [l]
         | otherwise = take n l: rows n (drop n l)


draw :: Float -> [[Picture]] -> Picture 
draw d [] = pictures []
draw d pss = pictures [shiftright d (head pss), shiftdown d (draw d (tail pss))]

shiftright:: Float-> [Picture]->Picture
shiftright d []=pictures []
shiftright d ps = pictures [head ps , translate d 0 (shiftright d (tail ps))]


shiftdown d  = translate 0 (-d) 

numbers = [text (show n) | n<- [1..11]]

{-
Christophs-MacBook-Pro:ex3 hh$ hlint ex15.hs
No suggestions
-}