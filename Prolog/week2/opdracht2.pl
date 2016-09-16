% Opdracht 2 Micha de Groot en Kaj Meijer


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

maakData([[mazelen,[hoofdpijn,buikpijn]],[rode_hond,[hoofdpijn,misselijk]]]).

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
volgendSymptoom([[Ziekte|[Symptomen]]|Ziektes],AlGevraagd,Symptoom):-
    (member(Symptoom,Symptomen),
    not(member(Symptoom,AlGevraagd)));
    volgendSymptoom(Ziektes,Algevraagd,Symptoom).

% Deze versie is voor als de eerste ziekte in de lijst geen symptomen meer heeft waar niet naar gevraagd is.
volgendSymptoom([[_|[Symptomen]]|Ziektes],AlGevraagd,Symptoom):-
   permutation(Symptomen,AlGevraagd),
   volgendSymptoom(Ziektes,AlGevraagd,Symptoom).

% Vraag naar een volgend symptoom, herhaal tot er een gevonden is
vraagSymptoom(Data,AlGevraagd,SymptoomOut,AlGevraagdNew):-
    volgendeVraag(Vraag), 
    write(Vraag),
    volgendSymptoom(Data,AlGevraagd,SymptoomIn),
    write(SymptoomIn),
    write('\n'),
    antwoord(Antwoord),
    (Antwoord = ja,
    SymptoomOut = SymptoomIn,
    AlGevraagdNew = AlGevraagd);
    (Antwoord = nee,
    AlGevraagdUpdate = [SymptoomIn|Algevraagd],
    vraagOpnieuw(Data,AlGevraagdUpdate,SymptoomOut,AlGevraagdNew)).

% afhandelen wat er moet gebeuren als iemand nee antwoord op een vraag
vraagOpnieuw(Data,AlGevraagd,SymptoomOut,AlGevraagdNew):-
    herhaalVraag(Vraag),
    write(Vraag),
    volgendSymptoom(Data,AlGevraagd,SymptoomIn),
    write(SymptoomIn),
    write('\n'),
    antwoord(Antwoord),
    (Antwoord = ja,
    SymptoomOut = SymptoomIn,
    AlGevraagdNew = AlGevraagd);
    (Antwoord = nee,
    AlGevraagdUpdate = [SymptoomIn|AlGevraagd],
    vraagOpnieuw(Data,AlGevraagdUpdate,SymptoomOut,AlGevraagdNew)).

% ask for a ja or a nee, otherwise retry
antwoord(CorrectAntwoord):-
    read(Antwoord),
    ((Antwoord = ja,
    CorrectAntwoord = ja),!;
    (Antwoord = nee,
    CorrectAntwoord = nee),!;
    (incorrectAntwoord(X),
    write(X),
    antwoord(CorrectAntwoord))).

% Diagnosticeer tot er nog één ziekte is
diagnosticeer([LaatsteZiekte],LaatsteZiekte,_).

diagnosticeer(Data,GereduceerdeData,AlGevraagd):-
    vraagSymptoom(Data,AlGevraagd,Symptoom,AlGevraagdNew),
    zoekZiekte(Data,Symptoom,NewData),
    diagnosticeer(NewData,GereduceerdeData,AlGevraagdNew).


diagnose:-
    maakData(Data),
    openingtext(T1),
    write(T1),
    eersteVraag(T2),
    write(T2),
    read(Symp1),
    zoekZiekte(Data,Symp1,NewData),
    diagnosticeer(NewData,[Ziekte|_],[]),!,
    write('Je hebt: '),
    write(Ziekte).
    %ask(NewData,Symp2),
    %zoekZiekte(NewData,Symp1,NewData2),
    %write(NewData2).


