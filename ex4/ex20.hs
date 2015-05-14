module Main where
import Graphics.Gloss

type Animation = Float -> Picture

clock1 t = pictures [
  back,
  minute t,
  second t,
  hour t
  ]

clock2 t = pictures [
  Color (greyN 0.8) back,
  minute t,
  second t,
  hour t
  ]


back = pictures $ [circleSolid 6,
  thickCircle 200 5]
  ++
  [ rotate a (translate 0 190 (rectangleSolid 5 20)) | a <- [0,30..330] ]
  ++
  [ rotate a (translate 0 180 (rectangleSolid 10 40)) | a <- [0,90..270] ]


minute t = rotate (fromInteger (180 + 6* floor (t / 60))) (translate 0 100 (rectangleSolid 3 200))
hour t   = rotate (fromInteger (75 + 6* floor (t / 3600)))  (translate 0 70 (rectangleSolid 3 140))
second t = rotate (fromInteger (floor t *6)) (translate 0 100 (rectangleSolid 2 200))

main = animate (InWindow "" (600, 600) (100,200)) white spedupFun


clocks = [(clock1,3),(clock2,3)]
clocksInf = cycle clocks


scene t = animateSequenceRel clocks fun

animateSequenceRel :: [(Animation,Float)] -> Animation -> Animation
animateSequenceRel (x:xs) _ = undefined
animateSequenceRel [] fallback = fallback

animateSequenceAbs :: [(Animation, Float)] -> Animation -> Animation
animateSequenceAbs = undefined









fun t = pictures [
    jumprope (5*t),
    translate (-210) 0 stickFigure,
    translate   210  0 stickFigure,
    jumper (5*t)
    ]
jumprope t = scale 1.75 (1.1 * sin t) rope
rope = line [ (x, 100 * cos (0.015 * x)) | x <- [-100, -75 .. 100 ] ]
stickFigure = pictures [
    line [ (-35, -100), (0, -25) ],
    line [ ( 35, -100), (0, -25) ],
    line [ (  0,  -25), (0,  50) ],
    line [ (-35,    0), (0,  40) ],
    line [ ( 35,    0), (0,  40) ],
    translate 0 75 (circle 25)
    ]
jumper t = translate 0 (max 0 (-50 * sin t)) stickFigure
