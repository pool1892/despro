{-
Im Graphikpaket Gloss werden Animationen als Abbildungen von Zeitpunkten in Bilder ge- fasst.
type Animation = Float → Picture
Schreiben Sie zwei Haskell-Funktionen, die Listen solcher Animationen nacheinander anzeigen.
animateSequenceRel ::[(Animation,Float)]→Animation→Animation animateSequenceAbs :: [ (Animation, Float) ] → Animation → Animation
Der erste Parameter ist eine Folge von Animationen und ihrer jeweiligen positiven Anzeige- dauer. 
Die Animationen sollen jeweils fu ̈r diese Dauer nacheinander angezeigt werden. 
Nach Ablauf aller Animationen in der Liste soll die Animation aus dem zweiten Parameter ge- zeigt werden. 
In der ersten Funktion sollen die Animationen jeweils zum Zeitpunkt 0 starten,
wa ̈hrend bei der zweiten Funktion die Animationen den tatsa ̈chlichen Zeitparameter erhalten sollen. 
Beispielsweise soll animateSequenceAbs (cycle [(clock1,3),(clock2,3)]) undefined alle 3 Sekunden zwischen zwei Uhren wechseln, 
wobei die angezeigte Zeit weiter voranschreitet. 
Versuchen Sie mo ̈glichst viel der Implementation der Funktionen animateSequenceRel und animateSequenceAbs zu teilen, statt getrennte Implementationen anzugeben. 
Idealerweise finden Sie eine Funktion, die beide Funktionalita ̈ten abdeckt und mittels derer Sie obige Funktionen als parametrisierte Aufrufe schreiben ko ̈nnen.
Geben Sie eine main-Definition an, die eine interessante Verwendung einer der beiden Funk- tionen animateSequenceRel und animateSequenceAbs demonstriert.
-}