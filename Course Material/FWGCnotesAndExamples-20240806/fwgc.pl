


% FWGC

% defining directions
  opposite(e,w).
  opposite(w,e).
  %sameside(e,e).
  %sameside(w,w).
 
% defining operations

  move(Cur, Next) :- fs(Cur, Next);fw(Cur,Next);
					fg(Cur,Next);fcab(Cur,Next).
  % farmer takes itself
  fs([F|T],[F1|T]) :- opposite(F,F1),not(unsafe([F1|T])).  
  % farmer takes wolf
  fw([FW,FW|T],[FW1,FW1|T]) :- opposite(FW,FW1), not(unsafe([FW1,FW1|T])). 
  % Farmer takes goat
  fg([FG,W,FG,C],[FG1,W,FG1,C]) :- opposite(FG,FG1), not(unsafe([FG1,W,FG1,C])).
  % Farmer takes cabagge
  fcab([FC,W,G,FC],[FC1,W,G,FC1]) :- opposite(FC,FC1), not(unsafe([FC1,W,G,FC1])).

  
  unsafe([F,W,W,_]) :- opposite(F,W).
  unsafe([F,_,G,G]) :- opposite(F,G).
  
  pprint([]) :- nl.
  pprint([H|T]) :- write(H), nl, pprint(T).

  % set up
  fwgc(Current,GoalState,SolutionPath) :- 
  	fwgc1(Current,GoalState,[Current],SolutionPath).
  
  % base case
  fwgc1(Current,Goalstate,PathSoFar,SolutionPath) :- 
	 Goalstate=Current,
  	 reverse(PathSoFar,SolutionPath).
  
  % recursive case
  fwgc1(Current, GoalState, PathSoFar, Path) 
  	:- move(Current,Next), not(member(Next, PathSoFar)), 
			% if yes, we've been to Next
  		fwgc1(Next,GoalState,[Next|PathSoFar],Path).
 
%GOALS
 %fwgc([w,w,w,w],[e,e,e,e], Path).
 %move([e,e,w,e], New).
% fwgc([e,w,e,e],[w,w,w,w],Path).
 %member(A, [a,b,c]).
 %fwgc1([e,e,e,e], [w,w,w,w], [[e,e,e,e]],Solution).