
module Main where
import Graphics.Gloss

main = display (InWindow "gloss clock" (600, 600) (100,120)) white halfpasttwoclock

halfpasttwoclock :: Picture
halfpasttwoclock = pictures
    [
      Color (greyN 0.8) clock,
      rotate 75 (translate 0 100 (rectangleSolid 10 170)),
      rotate 180 (translate 0 130 (rectangleSolid 5 230))
    ]

clock :: Picture
clock = pictures $
    [ rotate x (translate 0 240 (rectangleSolid 2 15)) | x <- [0,6..360] ] ++
    [ rotate x (translate 0 240 (rectangleSolid 4 30)) | x <- [0,30..330] ] ++
    [ rotate x (translate 0 230 (rectangleSolid 15 40)) | x <- [0,90..270] ] ++
    [
      circleSolid 10,
      thickCircle 255 10
    ]

