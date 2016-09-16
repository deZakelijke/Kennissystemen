% Opdracht 2 Micha de Groot en Kaj Meijer


% Alle teksten die gebruikt worden
openingtext(X):-
    X = 'Welkom bij onze diagnoseprogramma. We gaan u zo een aantal vragen stellen over uw symptomen. Beantwoord de vragen door het antwoord te typen in kleine letters met een punt er achter alstublieft.\n'.

eersteVraag(X):-
    X = 'De eerste vraag is: Wat is één van uw symptomen? U kunt kiezen uit de volgende opties:
    hoofdpijn
    buikpijn\n'.

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

maakData([[mazelen,[hoofdpijn,buikpijn]],[rode_hond,[hoofdpijn,misselijk]]]).

maakSymptomen([[_,Symptomen]],Symptomen).
maakSymptomen([[_,Symptomen]|Ziektes],GoedeSymptomen):-
    maakSymptomen(Ziektes,Symptomen2),
    append(Symptomen,Symptomen2,MeerSymptomen),
    set(MeerSymptomen,GoedeSymptomen).
    
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
    (Antwoord = ja,
    SymptoomOut = SymptoomIn,
    AlGevraagdNew = AlGevraagd);
    (Antwoord = nee,
    AlGevraagdUpdate = [SymptoomIn|Algevraagd],
    vraagOpnieuw(AlGevraagdUpdate,SymptoomOut,AlGevraagdNew,MogelijkeSymptomen)).

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
    maakData(Data),
    maakSymptomen(Data,MogelijkeSymptomen),
    openingtext(T1),
    write(T1),
    write(MogelijkeSymptomen),
    eersteVraag(T2),
    write(T2),
    read(Symp1),
    zoekZiekte(Data,Symp1,NewData),
    delete(MogelijkeSymptomen,Symp1,RedSymptomen),
    diagnosticeer(NewData,[Ziekte|_],[],RedSymptomen),!,
    write('Je hebt: '),
    write(Ziekte),
    afsluiting(Afsluiting),
    write(Afsluiting).
    


