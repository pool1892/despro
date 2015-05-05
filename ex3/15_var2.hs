module Main (main) where

import Graphics.Gloss

main = display (InWindow "grid" (800, 800) (0,0)) white scene

scene = grid 3 150 numbers

grid :: Int -> Float -> [Picture] -> Picture
grid columns distance ps = layout distance (group columns ps)

group :: Int -> [a] -> [[a]]
group _ [] = []
group n l = take n l : group n (drop n l)

layout :: Float -> [[Picture]] -> Picture
layout d x = subLayout 0 (-d) (map (subLayout d 0) x)

subLayout :: Float -> Float -> [Picture] -> Picture
subLayout d e [] = blank
subLayout d e [x] = x
subLayout d e (x:xs) = pictures (x : [translate d e (subLayout d e xs)])

numbers = [text (show n) | n <- [1..11]]
