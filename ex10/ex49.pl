/*
 * Schreiben Sie mittels des Mechanismus der Definite Clause Grammars
 * in Prolog ein Praedikat p/2 zur Erkennung genau der Zeichenketten
 * (wie "abbabaabba") in denen nur, und gleich viele, a und b vorkommen.
 * Zum Beispiel muss also p("abba","") erfolgreich sein.
 *
 * Denken Sie zurueck an die entsprechende Haskell-Aufgabe mit einem
 * Syntaxdiagramm.
 */


p -->  "".
p -->  "a", p, "b", p.
p -->  "b", p, "a", p.
