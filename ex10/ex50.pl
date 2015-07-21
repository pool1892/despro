/*
 * Definieren Sie mittels Definite Clause Grammars in Prolog einen Parser p/3
 * fuer die Sprache "a^n b^n", also zur Erkennung von Zeichenketten wie "aabb",
 * aber nicht zum Beispiel "abab" oder "aabbb", wobei Sie ein zusaetzliches
 * Argument verwenden, so dass man Anfragen formulieren kann, bei denen neben
 * der blossen Erkennung von Worten der Sprache "a^n b^n" auch jeweils das
 * entsprechende n (symbolisch notiert) beruecksichtigt/ausgegeben wird.
 *
 * Es soll also zum Beispiel:
 *
 *   p(s(s(0)),"aabb","").
 *
 * gelten, und die Anfrage:
 *
 *   p(N,"aaabbb","").
 *
 * muss N = s(s(s(0))) als Ergebnis liefern.
 */

p(0)-->"".
p(s(X))-->"a",p(X),"b".
