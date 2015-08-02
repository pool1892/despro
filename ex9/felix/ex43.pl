direct(frankfurt, san_francisco).
direct(frankfurt, chicago).
direct(san_francisco, honolulu).
direct(honolulu, maui).

connection(X, Y) :- direct(X, Z), connection(Z, Y).
connection(X, Y) :- direct(X, Y).
