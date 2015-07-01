female(juliet). female(petra).
parent(juliet , petra).
parent(juliet , paul ).
parent(petra , harry ).
parent(harry, luke).
parent(luke , tom ).

sister(X,Y) :- female(X), parent(Z,X), parent(Z,Y).
aunt(X,Y) :- sister(X,Z), parent(Z,Y).
grandmother(X,Y) :- female(X), parent(X,Z), parent(Z,Y).
ancestor(X,Y) :- grandmother(X,Y).
ancestor(X,Y) :- ancestor(X,Z), parent(Z,Y).


