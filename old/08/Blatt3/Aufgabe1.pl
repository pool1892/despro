
 % Fakten:

 mother(b,d).
 mother(b,e).

 father(a,d).
 father(c,e).
 father(d,f).
 father(d,g).

 father(g,a).

 days([sun,mon,tue,wed,thu,fri,sat]).





 % ancestor(X,Y) = "X ist Vorfahre von Y."

 ancestor(X,Y) :- father(X,Y).
 ancestor(X,Y) :- mother(X,Y).
 ancestor(X,Y) :- father(X,Z), ancestor(Z,Y).
 ancestor(X,Y) :- mother(X,Z), ancestor(Z,Y).





 % related (X,Y) = "X ist Vorfahre von Y oder Y ist Vorfahre von X oder
 %                  X und Y besitzen einen gemeinsamen Vorfahren."

 related(X,Y) :- ancestor(X,Y).
 related(X,Y) :- ancestor(X,Y).
 related(X,Y) :- ancestor(Z,X), ancestor(Z,Y), X \= Y.





 my_mod(X,Y,Result) :- integer(X), X >= 0,
                       integer(Y), Y >= 1,
                       my_mod_(X,Y,Result).

 my_mod_(X,Y,X)      :- X < Y, !.
 my_mod_(X,Y,Result) :- X1 is X - Y, my_mod_(X1,Y,Result).





 maximum(List,_)     :- var(List), !, fail.
 maximum([H|T], Max) :- number(H), !, maximum(H,T,Max).
 maximum([_|T], Max) :- maximum(T,Max).

 maximum(X,[],X).
 maximum(X,[H|T],Max) :- number(H), H > X, !, maximum(H,T,Max).
 maximum(X,[_|T],Max) :- maximum(X,T,Max).





 minimum(List,_)     :- var(List), !, fail.
 minimum([H|T], Min) :- number(H), !, minimum(H,T,Min).
 minimum([_|T], Min) :- minimum(T,Min).

 minimum(X,[],X).
 minimum(X,[H|T],Min) :- number(H), H < X, !, minimum(H,T,Min).
 minimum(X,[_|T],Min) :- minimum(X,T,Min).





 my_append([], L, L).
 my_append([H| T], L, [H| TL]) :- my_append(T, L, TL).

 last([X],X).
 last([_|T],Last) :- last(T,Last).

 last1(List,Last) :- my_append(_,[Last],List).





 delete1(_,[],[]).
 delete1(H,[H|T],T) :- !.
 delete1(Element,[H|T],[H|T1]) :- delete1(Element,T,T1).





 week_beginning(Day,Week) :- days(Days),
                             append(Prefix,[Day|Suffix],Days),
                             append([Day|Suffix],Prefix,Week).





 intersect([],_,[]).
 intersect([H|T],List2,[H|Rest]) :- member(H,List2), !, intersect(T,List2,Rest). % ohne Cut inkorrekt! 
 intersect([_|T],List2,Rest) :- intersect(T,List2,Rest).





 ancestor1(X,Y) :- ancestor1(Z,Y), father(X,Z). % faktenunabhängig!
 ancestor1(X,Y) :- ancestor1(Z,Y), mother(X,Z).