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



program:-
	open('knowledgebase2.txt', read, Str),
	read_kb(Str, KB),!,
	close(Str),
	mzl(KB, ZSL, ASL),
	delete(ZSL, end_of_file, ZiekteSymptomenLijst),
	write(ZiekteSymptomenLijst), nl,
	write(ASL).


read_kb(Stream, []):-
	at_end_of_stream(Stream).

read_kb(Stream, [H|T]):-
	\+ at_end_of_stream(Stream),
	read(Stream, H),
	read_kb(Stream, T).

mzl(Input, Output, ASL):-
	mzl(Input, [], Output, ASL).

mzl([H|T], Lijst, EindLijst, ASL):-
	mzsc(H, ZiekteSymptoomCombinatie, SymptomenLijst),
	append(Lijst, [ZiekteSymptoomCombinatie], ZiekteLijst),
	append(ASL, ASL1, ASL2),
	mzl(T, ZiekteLijst, EindLijst, ASL2).

mzl(H, Lijst, EindLijst, _):-
append(Lijst, H, EindLijst).

mzsc(Ziekte verklaart Symptomen, ZiekteSymptoomCombinatie, SymptomenLijst):-
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
