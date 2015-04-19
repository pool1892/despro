module Main (main) where

import Graphics.Gloss

main = display (InWindow "Bsp" (600, 600) (0,0)) white scene
       
scene = pictures
        [
          circleSolid 20
        , translate 25 0 (color red (polygon [(0,0),(10,-5),(10,5)]))
        ]
