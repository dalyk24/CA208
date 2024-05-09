/**
 CA208 CA2 Assignment
 Name: Killian Daly
 Student number: 22739355
 Declaration: I hereby declare that this assignment is all my own work,
 except elements that are attributed to another source, and is in
 accordance with DCU’s academic integrity policy.
*/

/* routes for testing */
route(dublin, cork, 200, fc).
route(dublin, limerick, 50, fct).
route(dublin, donegal, 60, cp).
route(donegal, laois, 60, fc).
route(cork, dublin, 200, fct).
route(cork, corkAirport, 20, fc).
route(corkAirport, cork, 25, fc).
route(dublin, dublinAirport, 10, fc).
route(dublinAirport, dublin, 20, fc).
route(dublinAirport, corkAirport, 225, p).
route(corkAirport, dublinAirport, 225, p).
route(limerick, laois, 60, fc).
route(cork, laois, 300, cpt).
route(laois, offaly, 400, pctf).
route(leitrim, tipperary, 6, pt).
route(dublin, antrim, 200, f).

/* Specifies the speed for a given mode of transport, like c = car */
modeSpeed(p, 500).
modeSpeed(t, 100).
modeSpeed(c, 80).
modeSpeed(f, 5).

/* Outputs the quickest time that has been found and the route stops */
printOutput(Src, Dest, [OutputTime, [OutputRoute|_]], Mode) :-
    append([Src], OutputRoute, SrcAndRoute),
    format('The quickest route from ~w to ~w using only ~w is ~w in ~w hours', [Src, Dest, Mode, SrcAndRoute, OutputTime]).

/* Gets a starting route value for comparison of routes */
getRoute([H|_], H).
/* Gets the time and stops of a route withing the list of all routes */
getRoute([RouteTime|RouteStops], RouteTime, RouteStops).

/* The base of where the list of routes is empty */
compareRoutes([], CurrQuickest, CurrQuickest).
/* Compares the current route's time in the list of routes to the current quickest and updates accordingly */
compareRoutes([CurrRoute|TailRoute], [H|_], QuickestRoute) :-
    getRoute(CurrRoute, RouteTime, RouteStops),
    RouteTime =< H,
    compareRoutes(TailRoute, [RouteTime, RouteStops], QuickestRoute).
/* If the current route isn't quicker then we move on the tail of the list without updating */
compareRoutes([_|TailRoute], CurrQuickest, QuickestRoute) :-
    compareRoutes(TailRoute, CurrQuickest, QuickestRoute).

/* Base case where the modes of tranport list is empty and we find the time by dividing distance by max of speeds */
calcTime([], Speeds, Dist, Time) :-
    max_list(Speeds, MaxSpeed),
    Time is Dist / MaxSpeed.
/* Uses the modeSpeed facts to get speed for a given mode then appends it to a list of all speeds */
calcTime([Head|Tail], Speeds, Dist, Time):-
    modeSpeed(Head, CurrSpeed),
    calcTime(Tail, [CurrSpeed|Speeds], Dist, Time).

/* Checks if the current stop has a mode of transport that matches the input available modes */
checkModes(Modes, StopMode, Dist, Time) :-
    string_chars(StopMode, StopModes),
    intersection(Modes, StopModes, ValidModes),
    ValidModes \= [],
    calcTime(ValidModes, [], Dist, Time).

/* Helps to initialise the accumulating total variables */
setTotal(TotalTime, TotalTime).

/* Base case of destination being reached, we set the total time and reverse the stops to appear chronologically */
journeyHandler(Src, Dest, Modes, Seen, Route, CurrTotal, TotalTime) :-
    route(Src, Dest, Dist, StopMode),
    checkModes(Modes, StopMode, Dist, Time),
    NewTotal is CurrTotal + Time,
    setTotal(NewTotal, TotalTime),
    reverse([Dest|Seen], NewSeen),
    Route = NewSeen.
/* We recusively check routes with each stop becoming the new source and checking if we've seen it already */
journeyHandler(Src, Dest, Modes, Seen, Route, CurrTotal, TotalTime) :-
    route(Src, Stop, Dist, StopMode),
    \+ member(Stop, Seen),
    checkModes(Modes, StopMode, Dist, Time),
    NewTotal is CurrTotal + Time,
    journeyHandler(Stop, Dest, Modes, [Stop|Seen], Route, NewTotal, TotalTime).

/* Builds a list of all routes, if none exist then the journey is impossible, finds the quickest and outputs it */
journey(Src, Dest, Mode) :-
    string_chars(Mode, Modes),
    findall([TotalTime, Route], journeyHandler(Src, Dest, Modes, [], Route, 0, TotalTime), AllRoutes),
    AllRoutes \= [],
    getRoute(AllRoutes, StartRoute),
    compareRoutes(AllRoutes, StartRoute, QuickestRoute),
    printOutput(Src, Dest, QuickestRoute, Mode), !.
