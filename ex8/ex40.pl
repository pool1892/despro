/*
 * Gegeben sei eine beliebige Datenbank von Fakten ueber verschiedene Punkte und (echte)
 * Strecken in der Ebene, etwa:
 */
line(a, b). line(c, b). line(d, a).
line(b, d). line(d, c). line(d, e).
/*
 * Implementieren Sie drei- bzw. vierstellige Praedikate "triangle" und
 * "tetragon" fuer mittels der gegebenen Strecken gebildete (echte) Drei- und
 * Vierecke. Eine Strecke bzw. ein Drei- oder Viereck heissen "echt" wenn
 * jeweils keine zwei der aufgefuehrten Punkte gleich sind.
 *
 * Beachten Sie ausserdem, dass die obige "line"-Relation nicht symmetrisch ist,
 * Verbindungen zwischen Punkten aber natuerlich konzeptionell doch.
 */

line1(A,B) :- line(A,B); line(B, A).
triangle1(A,B,C) :- line1(A,B), line1(A,C), line1(B,C).

triangle(A, B, C) :- triangle1(A,B,C), A\=B, B\=C, A\=C.

tetragon1(A,B,C, D) :- line1(A,B), line1(B,C), line1(C,D), line1(D,A).
tetragon(A, B, C, D) :- tetragon1(A,B,C,D), A\=B, B\=C, A\=C, A\=D, B\=D, C\=D.


