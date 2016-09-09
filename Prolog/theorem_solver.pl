% Prolog Homework # 6
% 17-09-2013
% Alessandra van Ree, 10547320, ap_vanree@hotmail.com


% Question 1

/*What needs to be done in this predicate is actually the opposite of what happens in unify_with_occurs_check/2, so we can make a predicate that works like (check_var/2) that and then calls a negation of that predicate in the occurs/2 predicate. The simplest check to make is when the second argument is already a variable. If this is the case, a cut is needed, because we don't want to put this into the prdicate for the more compicated terms in the second argument. Then prolog needs to check whether these two variables are not exactly the same using \==, because in the check_var/2 has to not be the same as the variable given. The other very simple check is when the second argument is an atom and in this case again a cut is needed for the same reason as before. Now for the more complicated terms (compound terms), =.. can be used to get the principal functor and the arguments in a list (respectively). Then we check the two arguments, in case of and infix operator, or the one argument in the list by recursively calling check_var/2 with those arguments as the second argument and the same variable as the first argument.*/

occurs(Variable, Term) :-
	var(Variable), !,
	\+ check_var(Variable, Term).

check_var(Variable, Term):-
	var(Term), !,
	Variable \== Term.

check_var(_, Atom):-
	atomic(Atom), !.

check_var(Variable, Term):-
	Term =.. [_, X, Y], !,
	check_var(Variable, X),
	check_var(Variable, Y).

check_var(Variable, Term):-
	Term =.. [_, X],
	check_var(Variable, X).

/*Examples of queries:
?- check_var(X, f(Y,g(b))).
true.

?- occurs(X, f(Y,g(b))).
false.

?- occurs(X, X).
true.

?- occurs(X, Y).
false.*/

% Questsion 2

/*All of the predicates have been copied into the file. First an operator needs to be made for implication. This in an left-associative infix operator with a weaker precedence than neg, and and or but stronger than ::. This because it isn't as strong bining as the first three but needs to go before the :: operator, because the implication needs to be processed before ::. Then form the Logic course is known that 'A implies B' is logically equivalent with 'neg A or B'. So if 'neg A or B' is true, we get f:: A and t:: B, with a split. But if it is false, we get t :: A and f :: B, without a split. The implication rule is below the disjunction and above the predicate for moving atoms to the second argument.*/

% Operators
:- op(100, fy, neg),
	op(200, yfx, and),
	op(300, yfx, or),
	op(400, yfx, implies),
	op(600, xfx, ::).

% Negation
tableau([t :: neg A | Forms], Atoms) :- !,
	tableau([f :: A | Forms], Atoms).

tableau([f :: neg A | Forms], Atoms) :- !,
	tableau([t :: A | Forms], Atoms).

% Conjunction
tableau([t :: A and B | Forms], Atoms) :- !,
	tableau([t :: A, t :: B | Forms], Atoms).

tableau([f :: A and B | Forms], Atoms) :- !,
	tableau([f :: A | Forms], Atoms),
	tableau([f :: B | Forms], Atoms).

% Disjunction
tableau([f :: A or B | Forms], Atoms) :- !,
	tableau([f :: A, f :: B | Forms], Atoms).

tableau([t :: A or B | Forms], Atoms) :- !,
	tableau([t :: A | Forms], Atoms),
	tableau([t :: B | Forms], Atoms).

% Implication
tableau([t :: A implies B | Forms], Atoms):- !,
	tableau([f :: A | Forms], Atoms),
	tableau([t :: B | Forms], Atoms).

tableau([f :: A implies B | Forms], Atoms):- !,
	tableau([t :: A, f :: B | Forms], Atoms).

% Moving to Atoms
tableau([Label :: Atom | Forms], Atoms):-
	atom(Atom), !,
	tableau(Forms, [Label :: Atom | Atoms]).

% Closing branches
tableau(_, Atoms) :-
	member(t :: A, Atoms),
	member(f :: A, Atoms), !.

tautology(Formula) :-
	tableau([f :: Formula], []).

/*Emxamples:
?- tautology(((a implies b) and (b implies c)) implies (a implies c)).
true.

?- tautology(a implies neg a).
false.*/

% Question 3

/*To prove that a formula is logically entaild by other formulas, we try to prove this by reduction to absurdity. This means we state that it doesn't logically entail. So the list of formulas needs to be true and the single formula needs to be false. But because there can be multiple formulas in the list of the first argument and every single formula needs to be true, another predicate is needed to do this one by one. The base case is an empty list giving an empty list as output. The lists bigger than this are split up in a head and tail, and we give an output with a head being t :: Head. Then we recursively put the tail as the new list in this predicate and now the head of the tail will be made true. This will keep going until the base case is hit and the tail of the second argument can be instantiated with [] and so on.*/

entails([Head | Tail], Formula):-
	true_premisses([Head | Tail], TrueList),
	tableau([f :: Formula | TrueList], Formula).

true_premisses([], []).

true_premisses([Head | Tail], [t :: Head | TrueTail]):-
	true_premisses(Tail, TrueTail).


/*Examples:
?- entails([a implies b, b implies c], a implies c).
true.

?- entails([a or b implies c], a implies neg c).
false.*/

% Question 4

/*To make the model predicate work there are three things we need to make it work. All the moves that are legal to make, a goal and the use of the right algorithm to get the right answers. To get all the legal moves the tableau/2 predicates are very usefull. Simply make the first and second argument the begin state, by putting it in a list, and make the second argument the NextNode. This NextNode (the state after the move has been made) will be defined by the state the formula is in when we get rid of a certain logical connective, such as negation. A move should be made for moving atomic formulas to Atoms as wel, because if we want to make a goal predicate, all the atomic formulas should be in there. The goal is reached when we can't close a branch, so it's not the case that we have an atom that is true and the same atom is false. This defines our goal predicate. Then an algorithm is needed. I think we need to use a version of depthfirst search, because we want to go through every branch to the very end to see whether it closes. When it does't, the goal succeeds and we get a/the path(s) that leads to the unclosing branch(es).*/

% Move negation
move([[t :: neg A | Forms], Atoms], NextNode) :- !,
	NextNode = [[f :: A | Forms], Atoms].

move([[f :: neg A | Forms], Atoms], NextNode) :- !,
	NextNode = [[t :: A | Forms], Atoms].

% Move conjunction
move([[t :: A and B | Forms], Atoms], NextNode) :- !,
	NextNode = [[t :: A, t :: B | Forms], Atoms].

move([[f :: A and B | Forms], Atoms], NextNode) :- !,
	(NextNode = [[f :: A | Forms], Atoms];
	NextNode = [[f :: B | Forms], Atoms]).

% Move disjunction
move([[f :: A or B | Forms], Atoms], NextNode) :- !,
	NextNode = [[f :: A, f :: B | Forms], Atoms].

move([[t :: A or B | Forms], Atoms], NextNode) :- !,
	(NextNode = [[t :: A | Forms], Atoms];
	NextNode = [[t :: B | Forms], Atoms]).

% Move implication
move([[t :: A implies B | Forms], Atoms], NextNode):- !,
	(NextNode = [[f :: A | Forms], Atoms];
	NextNode = [[t :: B | Forms], Atoms]).

move([[f :: A implies B | Forms], Atoms], NextNode):- !,
	NextNode = [[t :: A, f :: B | Forms], Atoms].

% Move move to Atoms
move([[Label :: Atom | Forms], Atoms], NextNode):-
	atom(Atom), !,
	NextNode = [Forms, [Label :: Atom | Atoms]].

% Goal
goal([[], Atoms]):-
	\+ (member(f :: A, Atoms), member(t :: A, Atoms)), !.

% Depthfirst
solve_depthfirst(Node, [Node|Path]) :-
  depthfirst(Node, Path).

depthfirst(Node, []) :-
  goal(Node).

depthfirst(Node, [NextNode|Path]) :-
  move(Node, NextNode),
  depthfirst(NextNode, Path).

/*Now for our model predicate, we need to first of all make all the formulas true, just like in question 3. So we call a predicate that works exactly the same like true_premisses/2. We need to make the formulas true, because we are trying to find models in which the formulas are true, and we can get those by finding branches that don't close (countelmodels) when we try to prove they make a contradiction. If we have a coutermodel for trying to prove that something is a contradiction, we have a model that does work for the formulas. Then we call the solve_depthfist to get the entire path to a branch that doesn't close. But we only want the last item in that list of the path, because we are looking for the atomic formulas that make the model true. We don't care about the first item in this last node, because this is an empty list (complex formulas are all converted into atomic formulas). Last but not least, sort is used to take out the duplicates of atomic formulas, and the output of sort will be the output of model/2.*/

% Model
model(Formulas, Model):-
	true_formulas(Formulas, TrueFormulas),
	solve_depthfirst([TrueFormulas, []], Path),
	last(Path, [_, ModelsDoubles]),
	sort(ModelsDoubles, Model).

true_formulas([], []).

true_formulas([Head | Tail], [t :: Head | TrueTail]):-
	true_formulas(Tail, TrueTail).

/*Examples:
?- model([neg (p and neg p) implies p and neg p], M).
false.

?- model([p or neg p], M).
M = [t::p] ;
M = [f::p] ;
false.

?- model([p and q, p implies q], M).
M = [t::p, t::q] ;
false.*/


