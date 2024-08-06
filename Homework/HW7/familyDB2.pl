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




