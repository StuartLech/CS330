
  
% Water Jugs Die hard 2 - DFS with prolog

  % set up interface:
  % SA, SB: Size of water jugs A and B with SA>SB
  % Goal = the desired amount of water in the larger jug
  % SP = Solution Path
  jugs(SA, SB, Goal, SP) :- 
  	jugs1([0,0,SA,SB],[Goal, _, SA, SB], [[0,0,SA,SB]],SP), 
	printJugs(SP).

  % base case
  jugs1(Current,Goal, PathSoFar,SP) :- Current=Goal, reverse(PathSoFar,SP).
  
  % recursive case
  jugs1(Current, GoalState, PathSoFar, SP) 
  	:- move(Current,Next), not(member(Next, PathSoFar)), 
  		jugs1(Next,GoalState,[Next|PathSoFar],SP).
 
  % Example Queries
  %jugs(5,3,4,Path).
  %jugs(6,4,3,Path),write("\nThe actions are:\n"),printjugs(Path).
  %jugs(91,67,19,Path).
  
  % Water jugs Die Hard with a Vengence  
  % Iterative Deepening Search (IDS) for optimal solution
  
  %call DLS version, starting at depth limit 1
  jugsIDS(SA, SB, Goal, SP) :- jugsDLS(SA, SB, Goal, SP, 1), !.
  
  % Depth-Limit Search (DLS)
  % 1. try to solve with current limit
  jugsDLS(SA, SB, Goal, SP, Limit) :- 
  	jugsDLS1([0,0, SA, SB],[Goal,_,SA,SB],[[0,0,SA,SB]],SP, Limit), 
		printJugs(SP), length(SP, L), 
		L1 is L-1, write(L1), write(' moves\n').
		
  % 2. DLS increment the depth limit when previous attempt failed
  jugsDLS(SA, SB, Goal, SP, Limit) :- 
	NewLimit is Limit+1, % write(NewLimit), nl,
    jugsDLS(SA, SB, Goal, SP, NewLimit).  
 
  
  % DLS base case
  jugsDLS1(Current,Goal, PathSoFar,SP, _) :- 
	Current=Goal, reverse(PathSoFar,SP).
  
  % recursive case
  jugsDLS1(Current, Goal, PathSoFar, SP, Limit) 
  	:- length(PathSoFar,L), L<Limit, move(Current,Next), 
	   not(member(Next, PathSoFar)), 
  		jugsDLS1(Next,Goal,[Next|PathSoFar],SP, Limit).




  printJugs([_]) :- write('The solution path:\n').
  printJugs([L1, L2|T]) :- print1(L1,L2), printJugs([L2|T]).
  
  print1([A1,B1,_,_], [A2,B2, _, _]) :- A1+B1=:=A2+B2, A1 > A2, write('A to B\n').
  print1([A1,B1,_,_], [A2,B2,_,_]) :- A1+B1=:=A2+B2, A1 < A2, write('B to A\n').
  print1([A1,B1,_,_], [A2,B2,_,_]) :- B1=B2, A1 < A2, write('Fill A\n').
  print1([_,B1,_,_], [A2,B2,_,_]) :- B1=B2, A2=0, write('Empty A\n').
  print1([A1,B1,_,_], [A2,B2,_,_]) :- A1=A2, B1 < B2, write('Fill B\n').
  print1([A1,_,_,_], [A2,B2,_,_]) :- A1=A2, B2=0, write('Empty B\n').



 
