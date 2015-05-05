
module Main where
import Graphics.Gloss

main = display (InWindow "gloss pearlnecklace" (1000,300) (0,100)) white (pearlnecklace [6, 2, 1])

pearlnecklace :: [Float] -> Picture
pearlnecklace [] = blank
pearlnecklace [x] = sCircle x
pearlnecklace (x:xs) = pictures (sCircle x : [sTranslate (x + head xs) 0 (pearlnecklace xs)])

sCircle x = circle (x*20)
sTranslate x = translate (x*20)
