midfix(leaf(X),[X]).
midfix(node(L,X,R), Res) :- midfix(L,LRes), midfix(R, RRes), append(Lres, [X|RRes], Res).

midfixCat(leaf(X), Ys,[X|Ys]).
midfixCat(node(L,X,R), Ys, Res) :- midfixCat(R,Ys,Z) , midfixCat(L,[X|Z], Res).