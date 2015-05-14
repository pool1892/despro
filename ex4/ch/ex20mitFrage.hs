
import Graphics.Gloss
import Prelude
import Data.Maybe
type Animation = Float -> Picture

{-
Hi!
Ich habe eine Frage zu dieser Version, sie funktioniert bisher nicht. Die Idee war, gleich zwei Listen an die Animationen anzuhängen,
eine mit dem Begin und eine mit dem Ende der jeweiligen Animation. Das macht buddy.
dancing macht dann eine Fallunterscheidung und schickt die inaktiven Animationen auf blank.

Meine Frage: Wie bekomme ich die Sache am Ende zusammengesetzt, so dass da eine einzelne Animation draus wird? Habe jede Menge "Listentricks" ausprobiert...Seh ich da was einfaches nicht?
Vielen Dank!
-}

animateSequenceRel :: [(Animation, Float)] -> Animation -> Animation
animateSequenceRel x y= buddy False x y

animateSequenceAbs :: [(Animation, Float)] -> Animation -> Animation
animateSequenceAbs x y = buddy True x y
    


buddy:: Bool-> [(Animation, Float)] -> Animation -> Animation
buddy bool x y = dotheanimation bool listicle 
  where listicle = (zip3  allfirst fixedsecond (0:fixedsecond))++[(y, maxsecond, -1)]---Liste von Dreiertupeln: Animation, Begin, End. Als letztes Element die finale Animation, ihr Begin ist nach den anderen und ihr Ende auf -1
        allfirst= fst(unzip x)--Die Animationen
        allsecond= fixerupper(snd(unzip x))--Die Dauern, sicherheitshalber negative auf 0 gesetzt, auch weil ich -1 brauche
        fixerupper= map security 
        security a | a<0 =0
        fixedsecond=  scanl1 (+) allsecond--Partialsummen gebildet
        maxsecond=last fixedsecond


        
dotheanimation:: Bool-> [(Animation, Float, Float)]  -> Animation
(dotheanimation boo x) t = (fix(map (dancing boo) x )) t---Hier bricht es zusammen, ich bekomme keine einzelne Animation zusammengesetzt, habe da ne Menge probiert. Gibt es einen Weg, das zu lösen oder ist die Idee mit den blanks prinzipiell unsinning?
  where fix [a]=[[a]]

dancing:: Bool-> (Animation, Float, Float) -> Animation---Diese Funktion sieht sich an, wo t gerade steht und schickt die einzelnen Animationen auf blank oder die (per Bool für abs oder rel) richtige Zeit.
(dancing may (x,y,z)) t 
  |t>=y&&z==(-1)   =walle
  |t<y          =blank
  |t>=y&&t<z     =walle
  where walle= if may then x t else x (t-y)


