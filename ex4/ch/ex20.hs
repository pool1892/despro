
import Graphics.Gloss

type Animation = Float -> Picture



animateSequenceRel :: [(Animation, Float)] -> Animation -> Animation
animateSequenceRel x y= buddy False x y

animateSequenceAbs :: [(Animation, Float)] -> Animation -> Animation
animateSequenceAbs x y = buddy True x y
    


buddy:: Bool-> [(Animation, Float)] -> Animation -> Animation
buddy bool x y = dotheanimation bool listicle y
  where listicle = zip allfirst fixedsecond
        allfirst= map fst x
        allsecond= map snd x
        fixedsecond=  scanl1 (+) allsecond

        
dotheanimation:: Bool-> [(Animation, Float)] -> Animation -> Animation
dotheanimation boo x y = foldr (dancing boo) y x 

dancing:: Bool-> (Animation, Float)-> Animation -> Animation
(dancing bx (erste, zeit) zweite) dauer
    |dauer< zeit = erste dauer
    | bx         = zweite dauer
    | otherwise  = zweite (dauer-zeit)





main :: IO()
main = animate 
        (InWindow "Wurst" (800, 800) (0, 0))
        white
        animation 




animation = animateSequenceRel y clock 
    where y=cycle [(clock,3)]

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

