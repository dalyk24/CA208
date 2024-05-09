north(a, f).
north(b, g).
north(c, h).
north(d, i).
north(e, j).
north(f, k).
north(g, l).
north(h, m).
north(i, n).
north(j, o).
north(k, p).
north(l, q).
north(m, r).
north(n, s).
north(o, t).

west(a, b).
west(b, c).
west(c, d).
west(d, e).
west(f, g).
west(g, h).
west(h, i).
west(i, j).
west(k, l).
west(l, m).
west(m, n).
west(n, o).
west(p, q).
west(q, r).
west(r, s).
west(s, t).

isNorth(X, Y) :- north(X, Y).
isNorth(X, Y) :- north(X, Z), isNorth(Z, Y).

isSouth(X, Y) :- north(Y, X).
isSouth(X, Y) :- north(Z, X), isSouth(Z, Y).

isWest(X, Y) :- west(X, Y).
isWest(X, Y) :- west(X, Z), isWest(Z, Y).

isEast(X, Y) :- west(Y, X).
isEast(X, Y) :- west(Z, X), isEast(Z, Y).

isNE(X, Y) :- isNorth(X, Z), isEast(Z, Y).








