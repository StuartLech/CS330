% An ever changing family - basic facts 
% could be extended to include mother, stepParent, uncle, descendant, etc

% parentOf
parent(don,ted).
parent(don,barb).
parent(don,paula).
parent(greg,erin).
parent(greg,austin).
parent(wes,alyssa).
parent(ted,jessica).
parent(ted,david).
parent(audrey,ted).
parent(audrey,barb).
parent(audrey,paula).
parent(paula,erin).
parent(paula,austin).
parent(barb,alyssa).
parent(mary,ann).   % new
parent(mary,sylvia). % new

% notice only one side is list but it's obviously bidirectional
married(don,audrey).
married(wes,barb).
married(greg,paula).
married(ted, mary).   % new

male(don).
male(ted).
male(greg).
male(austin).
male(david).

female(audrey).
female(barb).
female(wes).
female(paula).
female(alyssa).
female(jessica).
female(erin).
female(mary).   % new
female(sylvia). % new
female(ann).    % new

% Part I: Definitions for mother, ancestor, and stepParent
mother(X, Y) :- female(X), parent(X, Y).

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

stepParent(X, Y) :- married(X, Z), parent(Z, Y), not(parent(X, Y)).

% Part II: Working with Numbers and Lists
removeHT([_|T], L2) :- append(L2, [_], T).

level([], []).
level([H|T], FlatList) :-
    level(H, NewH),
    level(T, NewT),
    append(NewH, NewT, FlatList).
level(L, [L]) :- not(is_list(L)).

inserts(Elem, Index, OldList, NewList) :-
    length(Start, Index),
    append(Start, End, OldList),
    append(Start, [Elem|End], NewList).

% Part III: Water Jug Operations
fillA([_, B, CapA, CapB], [CapA, B, CapA, CapB]).
fillB([A, _, CapA, CapB], [A, CapB, CapA, CapB]).
emptyA([_, B, CapA, CapB], [0, B, CapA, CapB]).
emptyB([A, _, CapA, CapB], [A, 0, CapA, CapB]).
aToB([WaterA, WaterB, CapA, CapB], [NewWaterA, NewWaterB, CapA, CapB]) :-
    Transfer is min(WaterA, CapB - WaterB),
    NewWaterA is WaterA - Transfer,
    NewWaterB is WaterB + Transfer.
bToA([WaterA, WaterB, CapA, CapB], [NewWaterA, NewWaterB, CapA, CapB]) :-
    Transfer is min(WaterB, CapA - WaterA),
    NewWaterA is WaterA + Transfer,
    NewWaterB is WaterB - Transfer.

move(Current, Next) :- fillA(Current, Next); fillB(Current, Next); emptyA(Current, Next); emptyB(Current, Next); aToB(Current, Next); bToA(Current, Next).

% Ensure to test all definitions with appropriate queries to verify correctness.
