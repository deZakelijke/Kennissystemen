
% A standard adder
adder(Input1, Input2, Output):-
	Output is Input1 + Input2.

% A standard multiplier
multiplier(Input1, Input2, Output):-
	Output is Input1 * Input2.

% Model 1 from the assignment
model1(T1, T2, T3, Answer) :-
	adder(1, 1, T1),
	multiplier(5, T1, T3),
	multiplier(3, 2, T2),
	adder(T2, T3, Answer).

% Model 2 of the assignment
model2(T1, T2, T3, T4, T5, T6, T7, T8, AnswerMultiplier, AnswerAdder) :-
	multiplier(3, 2, T1),
	multiplier(3, 2, T2),
	multiplier(3, 2, T3),
	adder(T1, T2, T4),
	adder(T1, T3, T5),
	adder(T2, T3, T6),
	multiplier(T4, T5, T7),
	multiplier(T5, T6, T8),
	multiplier(T7, T8, AnswerMultiplier),
	adder(T7, T8, AnswerAdder).
        

askT(T,Value):-
    write("what is the value of: "),
    write(T),nl
    read(value).
