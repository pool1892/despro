% Solutions to some of the 99 Prolog Problems

% https://sites.google.com/site/prologsite/prolog-problems

my_last(X,[X]).
my_last(X,[_|XS]) :- my_last(X,XS). 

my_sndlast(X,[X,_]).
my_sndlast(X,[_|XS]) :- my_sndlast(X,XS). 

my_kthelement(X,[_|XS],K) :- my_kthelement(X,XS,L), K is L+1 .
my_kthelement(X,[X|_ ],1).

my_length(K,[_|XS]) :- my_length(L,XS), K is L+1 .
my_length(0,[]).
