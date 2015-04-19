module Main (main) where

import Graphics.Gloss

main = animate (InWindow "" (600, 600) (100,200)) white scene

scene t =
  scale 3 3 $ 
  pictures $
 [
 rotate a (color (makeColorI 87 0 0 (if (mod (round(40*t)) 510) < 255 
									then (mod (round(40*t)) 255) 
									else (255-(mod (round(40*t)) 255)))) (rectangleSolid 30 30)) | a <-[0,20..360]
  ]
  ++
  [color (makeColorI 87 0 0 10)(circleSolid a) | a <- [0,0.5..20]]
  ++
  [ rotate (a+10*t) (color (makeColorI 87 0 0 (round(a*255/90)))(rectangleWire (40+a) (40+a))) | a <- [90,85..0] ] 
  ++
  [ rotate (-a-10*t) (color (makeColorI 87 0 0 (round(a*255/90)))(rectangleWire (40+a) (40+a))) | a <- [0,5..90] ]
 ++
 [ rotate (-b*t) (translate b 0 (color magenta (polygon [(0,0),(10,-5),(10,5)]))) | b <- [0,10..80] ]
 ++
 [ rotate (b*t) (translate b 0 (color chartreuse (polygon [(0,0),(10,-5),(10,5)]))) | b <- [5,15..75] ]
 
  
insania = makeColorI 87 0 0 255
  
  