module Main where 
import Graphics.Gloss

halfpasttwoclock :: Picture 
halfpasttwoclock = pictures $
        [
          circleSolid 6,
          thickCircle 200 5,
       --  rotate 75 (line [(0,0), (0,140)]),
        rotate 75 (translate 0 70 (rectangleSolid 3 140)),
         rotate 180 (translate 0 100 (rectangleSolid 3 200))

                        ]
         ++
 		 [ rotate (a) (translate 0 190 (rectangleSolid 5 20)) | a <- [0,30..330] ]
 		 ++
 		 [ rotate (a) (translate 0 180 (rectangleSolid 10 40)) | a <- [0,90..270] ]


main = display (InWindow "gloss clock" 			-- Name of the window 
	(800, 600)									-- Width and height
	(0, 0)) 									-- Position
	white										-- Background color
	halfpasttwoclock							-- A picture

