module Main where
import Graphics.Gloss

type Animation = Float -> Picture

main = animate (InWindow "funsies" (600, 600) (100,200)) white scene

scene = animateSequenceRel clocks funsies
-- scene = animateSequenceAbs clocks funsies
-- scene = animateSequenceRel clocksInf funsies
-- scene = animateSequenceAbs clocksInf funsies

animateSequenceAbs :: [(Animation, Float)] -> Animation -> Animation
animateSequenceAbs l = animateSequence False (accumulatedList l)

animateSequenceRel :: [(Animation,Float)] -> Animation -> Animation
animateSequenceRel = animateSequence True

accumulatedList :: [(Animation, Float)] -> [(Animation, Float)]
accumulatedList l = zip (fst (unzip l)) (scanl1 (+) (snd (unzip l)))

animateSequence :: Bool -> [(Animation, Float)] -> Animation -> Animation
animateSequence rel list fallback = foldr (animateSequenceSep rel) fallback list

animateSequenceSep :: Bool -> (Animation, Float) -> Animation -> Animation
animateSequenceSep rel (a1, d) a2 t
  | t > d     = a2 (if rel then t-d else t)
  | otherwise = a1 t


clocks = [(clock1,5),(clock2,5)]
clocksInf = cycle clocks

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


funsies :: Animation
funsies t = pictures [
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
