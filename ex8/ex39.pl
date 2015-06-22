/*
 * Nehmen Sie an, eine beliebige Faktenbasis zu Elternschaftsbeziehungen sei gegeben,
 * (nur) beispielhaft etwa:
 */
female(mary).
female(sandra).
female(juliet).
female(lisa).
male(peter).
male(paul).
male(dick).
male(bob).
male(harry).
male(luke).
parent(lisa, harry).
parent(peter, harry).
parent(bob, mary).
parent(bob, lisa).
parent(bob, paul).
parent(juliet, mary).
parent(juliet, lisa).
parent(juliet, paul).
parent(mary, dick).
parent(mary, sandra).
parent(harry, luke).
/*
 * Dabei ist parent(X,Y) so zu verstehen dass X Elternteil von Y ist.
 */

a(X) :- parent(bob, X), female(X).
b(X) :- parent(X, Y), female(Y), parent(X, Z), male(Z).
c(X) :- sister(X, Y), male(Y).
d(X) :- mother(Y, X), Y \= juliet.


sister(X, Y) :- parent(P, X), parent(P, Y), female(X), X\=Y.
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
aunt(G,X) :-  parent(P,X),  sister(G,P).
grandmother(G,X) :-  parent(P,X),  mother(G,P).

/*
 * 1. Formulieren Sie Prolog-Anfragen nach:
 *
 * (a) Toechtern von Bob,
 * (b) Personen mit sowohl einer Tochter als auch einem Sohn,
 * (c) Schwestern (inklusive Halbschwestern) irgendeiner maennlichen Person,
 * (d) Personen mit einer Mutter verschieden von Juliet.
 *
 * (Notieren Sie die Anfragen als Regeln a(X) :- ..., b(X) :- ..., etc.)
 *
 * 2. Definieren Sie allgemeine Regeln fuer die folgenden Konzepte/Praedikate:
 *
 *     sister, father, aunt, grandmother.
 */
