
% naive_fib/2 --- compute the Nth Fibonacci number.

% base
naive_fib(1, 1).
naive_fib(2, 1). 

% general statement
naive_fib(N, F) :- N>2, 
			N1 is N-1, N2 is N-2, naive_fib(N1, F1), naive_fib(N2, F2), F is F1+F2. 

first([H|_], H). % only case for first 
last([H], H).  % base case for last 	
last([_|T], R) :- last(T, R).

%base case 
sum([], 0).
%sum([A], A). % this could be a base case

sum([H|T], S) :- sum(T, S1), S is H+S1.

%base case 
sumAll([], 0).
sumAll([H|T], S) :- number(H), sumAll(T, S1), S is H+S1.
sumAll([H|T], S) :- is_list(H), sumAll(T, S1), sumAll(H, S2), S is S1+S2.

iMember(H, [H|_]) .
%iMember(X, L) :- L = [H|T], X=H.

iMember(X, [_|T]) :- iMember(X,T).


iAppend([], Y, Y). % better, allowing copy of entire 2nd list to 3rd list 

%Recursive case: X+Y  Z

%X = [Hx|Tx]
%iAppend Tx to Y
%add Hx to beginning of the result of the last step


%recursive case, X has at least one element
iAppend([Hx|Tx], Y, [Hx|Tz]) :- iAppend(Tx, Y, Tz).



