/*
 * Definieren Sie mittels Definite Clause Grammars in Prolog einen Parser p/2
 * fuer die Sprache "a^n b^n c^n", also zur Erkennung von Zeichenketten wie
 * "aabbcc", aber nicht zum Beispiel "abcabc" oder "aabbbccc".
 */
p --> a(N),b(N),c(N).
a(0) --> "".
a(s(N)) --> "a", a(N).
b(0) --> "".
b(s(N)) --> "b", b(N).
c(0) --> "".
c(s(N)) --> "c", c(N).
