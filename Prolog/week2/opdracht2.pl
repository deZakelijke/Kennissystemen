% Opdracht 2 Micha de Groot en Kaj Meijer

% Knowledge base van Micha de Groot-10434410 en Kaj Meijer-10509534
% studie@michadegroot.nl en k.d.meijer17@gmail.com
% Kennissystemen 2016 tweede opdracht

% Het maakData predicaat leest de Ziekte verklaart Symptoom regels uit en interpreteert die
% Het zoekZiekte predicaat matcht een symptoom met een van de ziektes die ingelezen zijn ut het kennisbestand
% en 'verwijderd' de ziektes die dat symptoom niet hebben
% Daarna wordt er door middel van ja/nee vragen meer informatie vergaard en worden er 
% meer ziektes uitgesloten.
% Als er nog maar één mogelijke ziekte is dan wordt de conclusie getrokken dat de gebruiker
% die ziekte heeft

% Er wordt aangenomen dat de gebruiker voldoende symptomen heeft om tot een uniekte ziekte uit te komen.
% De gebruiker hoeft niet per se alle symptomen te hebben van de uiteindelijke ziekte.
% Het systeem zoekt het volgende symptoom om naar te vragen door bij de nog overgebleven ziektes
% Te kijken naar welk symptomen nog niet gevraagd is.

% operators die we moeten toevoegen
:- op(300, xfy, en).
:- op(700, xfy, verklaart).

en(A,B):-
    A,
    B.

verklaart(A,B):- A,B.
verklaart(A,_):- niet(A).

% Alle teksten die gebruikt worden
openingtext(X):-
    X = 'Welkom bij onze diagnoseprogramma. We gaan u zo een aantal vragen stellen over uw symptomen. Beantwoord de vragen door het antwoord te typen in kleine letters met een punt er achter alstublieft.\n'.

eersteVraag(X):-
    X = 'De eerste vraag is: Wat is één van uw symptomen? U kunt kiezen uit de volgende opties:'.

volgendeVraag(X):-
    X = 'Dankuwel. Heeft u last van het volgende symptoom? graag met ja of nee beantwoorden.\n'.

herhaalVraag(X):-
    X = 'Heeft u dan wel last van dit symptoom? \n'.

incorrectAntwoord(X):-
    X = 'Dat is geen valide antwoord. Graag antwoorden met ja of nee'.

afsluiting(X):-
    X = '\nDankuwel voor het gebruiken van onze diagnosesoftware.'.

geenUitsluitsel(X):-
    X = 'Het is ons niet gelukt om te betpalen welke ziekte u heeft'.

printSymptomen([Symptoom]):-
    write(Symptoom),nl.
printSymptomen([Symptoom|Symptomen]):-
    write(Symptoom),nl,
    printSymptomen(Symptomen).

maakData(ZiekteSymptomenLijst, AlleSymptomenLijst):- 
	open('knowledgebase2.txt', read, Str),
	read_kb(Str, KB),!,
	close(Str),
	mzl(KB, ZSL),
	delete(ZSL, end_of_file, ZiekteSymptomenLijst),
	asl(ZiekteSymptomenLijst, AlleSymptomenLijst).

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

asl(Input, Output):-
	asl(Input, [], Output).

asl([H|T], Lijst, ASL):-
	H = [_,Symptomen],
	append(Symptomen, Lijst, ASL1),
	asl(T, ASL1,ASL).

asl(H, Lijst, ASL):-
	append(H, Lijst, ASL).	

set([],[]).
set([H|T],[H|Out]) :-
    not(member(H,T)),
    set(T,Out).
set([H|T],Out) :-
    member(H,T),
    set(T,Out).

% Checks to find if Symptoom is a symptom of ziekte
matchZiekte([Ziekte, Symptomen],Symptoom,[Ziekte,SymptomenNew]):-
    member(Symptoom,Symptomen),
    delete(Symptomen,Symptoom,SymptomenNew).

% Checks for Symptoom. Either Ziekte is removed or Symptoom is removed from a match
zoekZiekte([Ziekte],Symptoom,Out):-
    (matchZiekte(Ziekte,Symptoom,ZiekteOut),
    Out = [ZiekteOut]);
    (not(matchZiekte(Ziekte,Symptoom,_)),
    Out = []).

% Recursive of above
zoekZiekte([Ziekte|Ziektes],Symptoom,Out):-
    (matchZiekte(Ziekte,Symptoom,ZiekteOut),
    zoekZiekte(Ziektes,Symptoom,ZiektesOut),
    Out = [ZiekteOut|ZiektesOut]);
    (not(matchZiekte(Ziekte,Symptoom,_)),
    zoekZiekte(Ziektes,Symptoom,ZiektesOut),
    Out = ZiektesOut).

% Pakt het volgende symptoom uit de database waar nog niet naar is gevraagd
volgendSymptoom(MogelijkeSymptomen,AlGevraagd,Symptoom):-
    member(Symptoom,MogelijkeSymptomen),
    not(member(Symptoom,AlGevraagd)).

% Vraag naar een volgend symptoom, herhaal tot er een gevonden is
vraagSymptoom(AlGevraagd,SymptoomOut,AlGevraagdNew,MogelijkeSymptomen):-
    volgendeVraag(Vraag), 
    write(Vraag),
    volgendSymptoom(MogelijkeSymptomen,AlGevraagd,SymptoomIn),
    write(SymptoomIn),nl,
    antwoord(Antwoord),
    ((Antwoord = ja,
    SymptoomOut = SymptoomIn,
    AlGevraagdNew = AlGevraagd);
    (Antwoord = nee,
    AlGevraagdUpdate = [SymptoomIn|AlGevraagd],
    vraagOpnieuw(AlGevraagdUpdate,SymptoomOut,AlGevraagdNew,MogelijkeSymptomen))).

% afhandelen wat er moet gebeuren als iemand nee antwoord op een vraag
vraagOpnieuw(AlGevraagd,SymptoomOut,AlGevraagdNew,MogelijkeSymptomen):-
    herhaalVraag(Vraag),
    write(Vraag),
    volgendSymptoom(MogelijkeSymptomen,AlGevraagd,SymptoomIn),
    write(SymptoomIn),nl,
    antwoord(Antwoord),
    ((Antwoord = ja,
    SymptoomOut = SymptoomIn,
    AlGevraagdNew = AlGevraagd);
    (Antwoord = nee,
    AlGevraagdUpdate = [SymptoomIn|AlGevraagd],
    vraagOpnieuw(AlGevraagdUpdate,SymptoomOut,AlGevraagdNew,MogelijkeSymptomen))).

% ask for a ja or a nee, otherwise retry
antwoord(CorrectAntwoord):-
    read(Antwoord),
    ((Antwoord = ja,
    CorrectAntwoord = ja),!;
    (Antwoord = nee,
    CorrectAntwoord = nee),!;
    (incorrectAntwoord(X),
    write(X),nl,
    antwoord(CorrectAntwoord))).

% Diagnosticeer tot er nog één ziekte is
diagnosticeer([LaatsteZiekte],LaatsteZiekte,_,_).

diagnosticeer(Data,GereduceerdeData,AlGevraagd,MogelijkeSymptomen):-
    vraagSymptoom(AlGevraagd,Symptoom,AlGevraagdNew,MogelijkeSymptomen),
    zoekZiekte(Data,Symptoom,NewData),
    delete(MogelijkeSymptomen,Symptoom,RedSymptomen),
    diagnosticeer(NewData,GereduceerdeData,AlGevraagdNew,RedSymptomen).


diagnose:-
    maakData(Data,MogelijkeSymptomen1),
    set(MogelijkeSymptomen1,MogelijkeSymptomen),
    openingtext(T1),
    write(T1),
    eersteVraag(T2),
    write(T2),nl,
    printSymptomen(MogelijkeSymptomen),
    read(Symp1),
    zoekZiekte(Data,Symp1,NewData),
    delete(MogelijkeSymptomen,Symp1,RedSymptomen),
    diagnosticeer(NewData,[Ziekte|_],[],RedSymptomen),!,
    write('Je hebt: '),
    write(Ziekte),
    afsluiting(Afsluiting),
    write(Afsluiting).
    


