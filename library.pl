book(illiad, homer, study, 500).
book(c, richie, study, 150).
book(testing, tester, reference, 200).
book(nt_bible, sams, reference, 480).
book(monty_python, cleese, comedy, 300).
book(dune, john, fiction, 300).
book(jjk, japan, action, 300).
book(school, testbook, study, 1300).
book(school2, com, comedy, 300).


buildLibrary(Lib) :- findall(book(Title, Author, Genre, Size),
                             book(Title, Author, Genre, Size), Lib).

isHoliday(book(_, _, Genre, Pages)) :- Genre \== reference , Genre \== study ,
    Pages < 400.
holiday(B, [B|_]) :- isHoliday(B).
holiday(B, [_|T]) :- holiday(B, T).

isRevision(book(_, _, Genre, Pages)) :- (Genre == reference ; Genre == study) ,
    Pages > 300.
revision(_,[]).
revision(B, [B|_]) :- isRevision(B).
revision(B, [_|L]) :- revision(B, L).

isLiterary(book(_, _, Genre, Pages)) :- Genre == drama.
literary(B, [B|_]) :- isLiterary(B).
literary(B, [_|L]) :- literary(B, L).

isLeisure(book(_, _, Genre, _)) :- Genre == comedy ; Genre == fiction.
leisure(B, [B|_]) :- isLeisure(B).
leisure(B, [_|L]) :- leisure(B, L).



