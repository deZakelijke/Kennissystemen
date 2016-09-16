% Knowledge base van Micha de Groot-10434410 en Kaj Meijer-10509534
% studie@michadegroot.nl en k.d.meijer17@gmail.com
% Kennissystemen 2016 eerste opdracht

% operators die we moeten toevoegen
:- op(300, xfy, en).
:- op(700, xfy, verklaart).

en(A,B):-
    A,
    B.

verklaart(A,B):- A,B.
verklaart(A,_):- niet(A).



main:-
	open('knowledgebase2.txt', read, Str),
	read_kb(Str, KB),!,
	close(Str),
	mzl(KB, Test),
	delete(Test, end_of_file, Test1),
	write(Test1), nl.

read_kb(Stream, []):-
	at_end_of_stream(Stream).

read_kb(Stream, [H|T]):-
	\+ at_end_of_stream(Stream),
	read(Stream, H),
	read_kb(Stream, T).

mzl(Input, Output):-
	mzl(Input, [], Output).

mzl([H|T], Lijst, EindLijst):-
	mzsc(H, ZiekteSymptoomCombinatie),
	append(Lijst, [ZiekteSymptoomCombinatie], ZiekteLijst),
	mzl(T, ZiekteLijst, EindLijst).

mzl(H, Lijst, EindLijst):-
append(Lijst, H, EindLijst).

mzsc(Ziekte verklaart Symptomen, ZiekteSymptoomCombinatie):-
	msl(Symptomen, SymptomenLijst),
	ZiekteSymptoomCombinatie = [Ziekte, SymptomenLijst].


msl(Symptomen, SymptomenLijst):-
	msl(Symptomen, [], SymptomenLijst).

msl(Symptoom en Symptomen, Lijst, EindLijst):-
	append([Symptoom], Lijst, NieuweLijst),
	msl(Symptomen, NieuweLijst, EindLijst). 	

msl(Symptoom, SymptomenLijst, EindLijst):-
	not(Symptoom = _ en _),
	append([Symptoom], SymptomenLijst, EindLijst).