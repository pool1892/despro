
module Main where
import Graphics.Gloss
import Prelude
animation t = clock t

clock t = pictures [
    background,
    minute t,
    second t,
    hour t
    ]
background = pictures $ [circleSolid 6,
              thickCircle 200 5]
              ++
              [ rotate (a) (translate 0 190 (rectangleSolid 5 20)) | a <- [0,30..330] ]
          ++
          [ rotate (a) (translate 0 180 (rectangleSolid 10 40)) | a <- [0,90..270] ]

    
minute t =          rotate (fromInteger (180 + 6* floor (t / 60))) (translate 0 100 (rectangleSolid 3 200))
hour t  =     rotate (fromInteger (75 + 6* floor (t / 3600)))  (translate 0 70 (rectangleSolid 3 140))
second t =      rotate (fromInteger ((floor t)*6)) (translate 0 100 (rectangleSolid 2 200))

main = animate (InWindow "" (600, 600) (100,200)) white animation