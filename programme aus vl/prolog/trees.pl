% Prolog problem #4.01

istree(nil).
istree(t(_,L,R)) :- istree(L), istree(R).

% Prolog problem #4.02

even(N) :- mod(N,2) =:= 0.
odd(N) :- mod(N,2) =:= 1.

approxHalf(N,K,M) :- even(N), K is N //2, M is K.
approxHalf(N,K,M) :- odd(N), K is N //2, M is K+1.
approxHalf(N,K,M) :- odd(N), M is N //2, K is M +1.

cbal_tree(0,nil).
cbal_tree(N,t(x,L,R)) :- N > 0, approxHalf(N-1,NL,NR), cbal_tree(NL,L), cbal_tree(NR,R).
