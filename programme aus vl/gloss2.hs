module Main (main) where

import System.Random

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Animate

main = animateIO (InWindow "" (600, 600) (100,200)) white scene

scene t = randomRIO (-5,5) >>= \r -> return $
  translate (10*t) r (color red (polygon [(0,0),(10,-5),(10,5)]))
