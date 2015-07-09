move(Xs,X,Ys) :- member(X,Xs), delete(Xs,X,Ys).

sum15(As) :- move(As,A1,Xs), move(Xs,A2,Ys), move(Ys,A3,_), A is A1+A2+A3, A=15.

to_win(As,Bs,Xs,X) :- move(Xs,X,Ys), A1 = [X|As],
                      (sum15(A1); will_lose(Bs,A1,Ys)).

will_lose(Bs,As,Ys) :- Ys\=[], not((move(Ys,Y,Zs), B1=[Y|Bs],
                                    (sum15(B1); not(to_win(As,B1,Zs,_)))
                                   )).

to_draw(As,Bs,Xs,X) :- move(Xs,X,Ys), A1=[X|As],
                       (Ys=[]; not(to_win(Bs,A1,Ys,_))).

start :- As=[], Bs=[], Xs=[1,2,3,4,5,6,7,8,9], show(As,Bs,Xs), play(As,Bs,Xs).

show(As,Bs,Xs) :- print((As,Bs,Xs)), nl.

play(As,Bs,Xs) :- read(A), !, move(Xs,A,Ys), A1=[A|As],
                  %show(Bs,A1,Ys),
                  (sum15(A1); Ys=[]; reply(Bs,A1,Ys)).

reply(Bs,As,Ys) :- (to_win(Bs,As,Ys,B); to_draw(Bs,As,Ys,B)),
                   !, move(Ys,B,Zs), B1=[B|Bs],
                   show(As,B1,Zs),
                   (sum15(B1); Zs=[]; play(As,B1,Zs)).
