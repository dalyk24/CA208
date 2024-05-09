parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(tom, steve).
parent(bob, ann).
parent(bob, mary).
parent(mary, jim).
parent(liz, alisson).
parent(liz, jessie).

female(pam).
female(liz).
female(ann).
female(mary).
male(bob).
male(tom).
male(steve).
male(jim).

brother(X, Y) :- male(X), parent(Z, X), parent(Z, Y), X \= Y.
sister(X, Y) :- female(X), parent(Z, X), parent(Z, Y), X \= Y.

uncle(X, Y) :- parent(Z, Y), brother(X, Z).
aunt(X, Y) :- parent(Z, Y), sister(X, Z).

cousin(X, Y) :- uncle(Z, X), parent(Z, Y).
cousin(X, Y) :- aunt(Z, X), parent(Z, Y).

predecessor(X,Y) :- parent(X,Y).
predecessor(X,Y) :- parent(X,Z), predecessor(Z,Y).



% Base case: an empty list has length 0
length([], 0).

% Recursive case: a list with at least one element has length L+1, where L is the length of the tail of the list
length([_ | Tail], Length) :-
    length(Tail, TailLength),
    Length is TailLength + 1.


