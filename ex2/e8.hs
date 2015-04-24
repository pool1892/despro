{- Aufgabe 8 (einzureichen u ̈ber eCampus, als Quelldatei, [4P]).
Erweitern Sie die Analoguhr aus dem vorigen U ̈bungszettel, so dass die angezeigte Zeit mit der tatsa ̈chlichen Zeit voranschreitet. 
Verwenden Sie dazu die Funktion animate aus dem Haskell-Paket Gloss, beispielsweise durch Verwendung der folgenden Vorlage.
Sollte Ihre Uhr keinen Sekundenzeiger haben, so soll sie mit 60facher Geschwindigkeit einer normalen Uhr laufen. 
Die angezeigte Uhrzeit bei Programmstart soll weiterhin 2:30 sein.
Ihr Minuten- oder Sekundenzeiger soll dabei ”ticken“, 
d.h. keine kontinuierliche Bewegung durchfu ̈hren sondern sich nur zu vollen Sekunden (Realzeit) bewegen.

-}
module Main where
import Graphics.Gloss
clock :: Float ->Picture
clock seconds = [
          circleSolid 6,
          thickCircle 200 5,
       --  rotate 75 (line [(0,0), (0,140)]),
        rotate 75 (translate 0 70 (rectangleSolid 3 140)),
         rotate 180 (translate 0 100 (rectangleSolid 3 200))

                        ]
         ++
 		 [ rotate (a)*seconds (translate 0 190 (rectangleSolid 5 20)) | a <- [0,30..330] ]
 		 ++
 		 [ rotate (a) (translate 0 180 (rectangleSolid 10 40)) | a <- [0,90..270] ]


main = animate (InWindow "gloss clock" 
		(800, 600)
		(0, 0))
	white 
	clock

-- halfpasttwoclock = pictures $
--         [
--           circleSolid 6,
--           thickCircle 200 5,
--        --  rotate 75 (line [(0,0), (0,140)]),
--         rotate 75 (translate 0 70 (rectangleSolid 3 140)),
--          rotate 180 (translate 0 100 (rectangleSolid 3 200))

--                         ]
--          ++
--  		 [ rotate (a) (translate 0 190 (rectangleSolid 5 20)) | a <- [0,30..330] ]
--  		 ++
--  		 [ rotate (a) (translate 0 180 (rectangleSolid 10 40)) | a <- [0,90..270] ]



-- scene t =
--   scale 3 3 $ 
--   pictures $
--   [
--     circle 80
--   , color green (rectangleSolid 40 40)
--   , rotate (-30*t) (translate 80 0 (color red (polygon [(0,0),(10,-5),(10,5)])))
--   ]
--   ++
--   [ rotate (a+10*t) (rectangleWire (40+a) (40+a)) | a <- [0,5..90] ]
