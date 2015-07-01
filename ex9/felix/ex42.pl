/*
 * Schreiben Sie in Prolog Praedikate zum Traversieren von mittels einstelligem
 * leaf und dreistelligem node gebildeten Baeumen
 *
 *    1. ... entsprechend der Haskell-Funktion
 *
 *             midfix (Leaf x)     = [x]
 *             midfix (Node l x r) = midfix l ++ [x] ++ midfix r
 *
 *           unter Verwendung des vordefinierten Prolog-Praedikats append (fuer ++).
 *
 *    2. ... ohne Verwendung von append, entsprechend der Optimierung (in Haskell)
 *           zur Vermeidung von ++ (siehe 12. Vorlesung).
 *
 * Die Praedikate fuer 1. und 2. sollen midfix (mit zwei Argumenten) bzw. midfixCat
 * (mit drei Argumenten) heissen. Es sollen also zum Beispiel gelten:
 *
 * midfix(node(node(leaf(1),2,leaf(3)),4,leaf(5)),[1,2,3,4,5]).
 *
 * midfixCat(node(node(leaf(a),b,leaf(c)),d,leaf(e)),[f,g],[a,b,c,d,e,f,g]).
 */

midfix(leaf(A),[A]).
midfix(node(L,A,R), Res) :- midfix(L,Lres), midfix(R, Rres), append(Lres, [A|Rres], Res).

midfixCat(leaf(A), Bs, [A|Bs]).
midfixCat(node(L,A,R), Bs, Res):- midfixCat(R,Bs,Z), midfixCat(L,[A|Z], Res).
