%called with isElem(2, [1, 2, 3, 4]).

myElem(X, A) :- member(X, A).

myHead(X, [A|_]) :- X == A.

myLast(X, [A]) :- X == A.
myLast(X, [_|A]) :- myLast(X, A).

checkTail(X, [_|A]) :- member(X, A).
myTail(X, [_|A]) :- checkTail(X, A).

myAppend(A, B, C) :- append(A, B, C).

myDelete(X, [X|Tail], Tail).
myDelete(X, [Y|Tail1], [W|Tail2]) :- myDelete(X, Tail1 , Tail2).


%recursively builds up reverse list by popping head and appending it
myReverse([], []).
myReverse([H|T], Reversed) :-
    myReverse(T, RestReversed),
    append(RestReversed, [H], Reversed).



