

 % prefix(A,B) = A ist Präfix von B

 prefix([],[]).

 prefix([],[_|_]).

 prefix([H|T1],[H|T2]) :- prefix(T1,T2).
 

 % suffix(A,B) = A ist Suffix von B
 
 suffix([],[]).

 suffix([H|T],[H|T]).

 suffix(L,[_|T]) :- suffix(L,T).




















 % nth_member(n,List,Result) = Result ist das n-te Element der Liste List
 
 nth_member(1, [H|_], H).

 nth_member(N, [_|T], M) :- N > 1, N1 is N-1, nth_member(N1, T, M).
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  % sublist(A,B) = A ist Teilliste von B
  
  sublist(S,L) :- prefix(P,L), suffix(S,P).
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  % halves(L,A,B) = A ist die linke, B die rechte Hälfte der Liste L
  
  halves(L,A,B) :- hv(L,[],A,B).

  hv(L,L,[],L).

  hv([H|T],Acc,[H|L],B) :- hv(T,[_|Acc],L,B).





















 % even_odd(L,E,O) = E ist der gerade, O der ungerade Teil der Liste L

 even_odd(L,E,O) :- odd(L,E,O).

 odd([], [], []).

 odd([H|T],E,[H|O]) :- even(T,E,O).

 even([], [], []).

 even([H|T],[H|E],O) :- odd(T,E,O).











 % revert(L,R) = R ist die Umkehrung der Liste L

 revert([],[]).

 revert([H|T],Rev) :- revert(T,RT), append(RT, [H], Rev).












 % perm(L,P) = P ist eine Permutation der Liste L
 %
 % delete(E,L,R) = R entsteht aus der Liste L durch Löschen des Elements E

 perm([],[]).

 perm(List,[H|Perm]) :- delete(H,List,Rest), perm(Rest,Perm).

 delete(X,[X|T],T).
 
 delete(X,[H|T], [H|NT]) :- delete(X,T,NT).








 % merge(L1,L2,L) = L entsteht durch Ineinandermischen der sortierten Listen L1 und L2

 merge(L1,[],L1).
 
 merge([],L2,L2).

 merge([X|T1], [Y|T2], [X|T]) :- X =< Y, merge(T1, [Y|T2], T).

 merge([X|T1], [Y|T2], [Y|T]) :- X > Y, merge([X|T1], T2, T).








 % Kombination ohne Wiederholung = N-elementige Teilliste (unter Berücksichtigung der Reihenfolge)
 %
 % comb(N,L,R) = R ist N-elementige Kombination der Liste L

 comb(0,_,[]).

 comb(N,[X|T],[X|Comb]) :- N > 0, N1 is N-1, comb(N1, T, Comb).

 comb(N,[_|T],Comb) :- N > 0, comb(N, T, Comb).


 % Kombination mit Wiederholung

 comb_r(0,_,[]).
 
 comb_r(N,[X|T],[X|RComb]) :- N > 0, N1 is N-1, comb_r(N1, [X|T], RComb).

 comb_r(N,[_|T],Comb) :- N > 0, comb_r(N, T, Comb).









 
 % Variation ohne Wiederholung = N-elementige Teilliste (ohne Berücksichtigung der Reihenfolge)
 %
 % varia(N,L,R) = R ist N-elementige Variation der Liste L

 varia(0,_,[]).

 varia(N,L,[H|Varia]) :- N > 0, N1 is N-1, delete(H, L, Rest), varia(N1, Rest, Varia).


 % Variation mit Wiederholung

 varia_r(0,_,[]).

 varia_r(N,L,[H|RVaria]) :- N > 0, N1 is N-1, delete(H, L, _), varia_r(N1, L, RVaria).
