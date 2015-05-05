{-Gegeben seien die folgenden Funktionsdefinitionen:
f :: [Int] → [Int] → [Int]
f[] []=[]
f [] ys = f [head ys] [] 
f (x : xs) ys = if null ys
                then [1]
                else g (x+1)3 : f (tail xs) [0]

g :: Int → Int → Int 
g 4 y = 3 
g x y = y+y
sowie die vordefinierten Funktionen null, head und tail.
Notieren Sie die einzelnen Auswertungsschritte fu ̈r folgenden Ausdruck (bis zum Endergebnis, und unter genauer Beachtung von Haskells Auswertungsstrategie!):
f [1,2][3]
{ applying f } ={...}
.
Verwenden Sie die Notationsform aus dem Kapitel zu ”Lazy evaluation“ aus dem Buch von Graham Hutton. -}


f[1,2][3]
= {applying f}
 f (1:[2]) [3] =if null [3]
                then [1]
                else g (1+1) 3 : f (tail [2]) [0]
= {applying null [3]}
f (1:[2]) [3] =if false
                then [1]
                else g (1+1) 3 : f (tail [2]) [0]
={applying if else}
f (1:[2]) [3] = g (1+1) 3 : f (tail [2]) [0]
={applying (1+1)}
f (1:[2]) [3] = g 2 3 : f (tail [2]) [0]
={applying g}
f (1:[2]) [3] = 3+3 : f (tail [2]) [0]
={applying +}
f (1:[2]) [3] = 6 : f (tail [2]) [0]
={applying tail [2]}
f (1:[2]) [3] = 6 : f ([]) [0]
={applying f}
f (1:[2]) [3] = 6 : f [head [0]][]
={applying head}
f (1:[2]) [3] = 6 : f [0][]
={applying f}
f (1:[2]) [3] = 6 : if null []
                then [1]
                else g (0+1) 3 : f (tail []) [0]
={applying null}
f (1:[2]) [3] = 6 : if True
                then [1]
                else g (0+1) 3 : f (tail []) [0]
={applying if else}
f (1:[2]) [3] = 6 : [1]=[6,1]

