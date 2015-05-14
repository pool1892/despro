import Graphics.Gloss

type Animation = Float -> Picture

animateSequenceRel :: [(Animation, Float)] -> Animation -> Animation
animateSequenceRel = animationHelper False

-- animateSequenceAbs uebergibt animationHelper eine Liste mit aufaddierten Animationszeiten
animateSequenceAbs :: [(Animation, Float)] -> Animation -> Animation
animateSequenceAbs list endAni = 
    let listUnzipped = unzip list
        listDur = zip (fst listUnzipped) (scanl1 (+) (snd listUnzipped))
    in 
    animationHelper True listDur endAni

{- animationHelper fungiert als Schnittstelle zwischen den eigentlichen Funktionen und animateFor
 - wendet animateFor sukzessiv durch foldr auf die gegebene Liste der Animationen an
 -}
-- animationHelper :: isAbs -> listOfAnimationsAndDurations -> endAnimation -> animationsForTheirDurationsInSeries
animationHelper :: Bool -> [(Animation, Float)] -> Animation -> Animation
animationHelper isAbs list endAni = foldr (animateFor isAbs) endAni list

-- animateFor spielt Animation1 fuer die gegebene Dauer ab und danach Animation2
-- animateFor :: isAbs -> (animation1, durationOfAnimation1) -> animation2 -> animation1ForDurationThenAnimation2
animateFor :: Bool -> (Animation, Float) -> Animation -> Animation
(animateFor isAbs (ani1, dur) ani2) time 
    | time < dur = ani1 time
    | isAbs      = ani2 time 
    | otherwise  = ani2 (time - dur)

main :: IO()
main = animate 
        (InWindow "Lucy in the Sky with Diamonds" (800, 800) (0, 0))
        white
        (animateSequenceAbs (cycle[(x, dur)| x <- [clock1, clock2, clock3, clock4, clock4, clock3, clock2, clock1]]) undefined) where dur = 1/16


-- abgeaenderter Sourcecode aus Aufgabe08
clockCreator :: Color -> Float -> Animation
(clockCreator col number) t = 
    pictures $
    [color col(thickCircle (200 + number*5) 5), color col (circleSolid (12 + number*2))]
    ++
    [rotate a (translate (195 - number*5) 0 (color col(rectangleSolid (10 + number*10) 3))) | a<-[0,30..330]]
    ++
    [rotate a (translate (190 - number*5) 0 (color col(rectangleSolid (20 + number*15) 5)))  | a<-[0,90..270]]	
    ++
    -- Sekundenzeiger
    -- Faktor 6 ergibt sich aus: 360°/60sec
    [rotate (fromIntegral(floor t)*6)(rotate (-90)(translate ((85 + number*20)/2) 0 (color col(rectangleSolid (85 + number*20) 3))))]
    ++
    -- Minutenzeiger
    [rotate (fromIntegral(floor t `div` 60)*6)(rotate 90(translate ((75 + number*15)/2) 0(color col(rectangleSolid (75 + number*15) 5))))]
    ++
    --Stundenzeiger
    -- Faktor 120 ergibt sich aus (360°/Umdrehung)/(12h/Umdrehung)*secsToHours
    [rotate (t/120)(rotate (-360/24)(translate ((90 + number*10)/2) 0(color col(rectangleSolid (90 + number*10) 10))))]

clock1 :: Animation
clock1 = clockCreator black 0

clock2 :: Animation
clock2 = clockCreator red 1
    
clock3 :: Animation
clock3 = clockCreator green 2

clock4 :: Animation
clock4 = clockCreator yellow 3

{- hlint:
 - No suggestions
 -}