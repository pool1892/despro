module Main (main) where

import Graphics.Gloss

main = animate (InWindow "" (600, 600) (100,200)) white scene

scene t =
  scale 3 3 $ 
  pictures $
  [
    circle 80
  , color green (rectangleSolid 40 40)
  , rotate (-30*t) (translate 80 0 (color red (polygon [(0,0),(10,-5),(10,5)])))
  ]
  ++
  [ rotate (a+10*t) (rectangleWire (40+a) (40+a)) | a <- [0,5..90] ]
