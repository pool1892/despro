Das sind die Autotoolaufgaben 50 und 51, sie funktionieren, generieren aber, beispielsweise, "a,a,b,b,c,c" statt "aabbcc".
Ich finde da gerade keine Lösung... habe so Dinge wie c(s(N)) --> [c|x],{x is c(N)} probiert.
Muss jetzt leider schlafen.


p --> a(N),b(N),c(N).
a(0) --> [].
a(s(N)) --> [a], a(N).
b(0) --> [].
b(s(N)) --> [b], b(N).
c(0) --> [].
c(s(N)) --> [c],c(N).

p(N)--> a(N),b(N).
a(0) --> [].
a(s(N)) --> [a], a(N).
b(0) --> [].
b(s(N)) --> [b], b(N).

