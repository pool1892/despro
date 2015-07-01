direct(frankfurt ,san francisco). direct(frankfurt ,chicago).
direct ( san francisco , honolulu ). direct(honolulu ,maui).
connection(X, Y) :− direct(X, Y).
connection(X, Y) :− direct(X, Z), connection(Z, Y).
