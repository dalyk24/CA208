/* NORTH FACTS */
north(a, f).
north(f, k).
north(k, p).
north(b, g).
north(g, l).
north(l, 'q').
north(c, h).
north(h, 'm').
north('m', r).
north(d, i).
north(i, n).
north(n, 's').
north(e, j).
north(j, o).
north(o, t).

/* EAST FACTS */
east(a, b).
east(b, c).
east(c, d).
east(d,e).
east(f, g).
east(g, h).
east(h, i).
east(i, j).
east(k, l).
east(l, 'm').
east('m', n).
east(n, o).
east(p, 'q').
east('q', r).
east(r, 's').
east('s', t).

directSouth(X, Y) :- north(Y, X).
directWest(X, Y) :- east(Y, X).

isNorth(Z, Y) :- north(Z, Y).
isNorth(X, Y) :- north(X, Z), isNorth(Z, Y).

isSouth(Z, Y) :- directSouth(Z, Y).
isSouth(X, Y) :- directSouth(X, Z), isSouth(Z, Y).

isEast(Z, Y) :- east(Z, Y).
isEast(X, Y) :- east(X, Z), isEast(Z, Y).

isWest(Z, Y) :- directWest(Z, Y).
isWest(X, Y) :- directWest(X, Z), isWest(Z, Y).

isNEast(X, Y) :- isNorth(X, Z), isEast(Y, Z).


