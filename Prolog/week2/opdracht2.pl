% Opdracht 2 Micha de Groot en Kaj Meijer


openingtext(X):-
    X = 'Welkom bij onze diagnoseprogramma. We gaan u zo een aantal vragen stellen over uw symptomen. Beantwoord de vragen door het antwoord te typen in kleine letters met een punt er achter alstublieft.\n'.

eersteVraag(X):-
    X = 'De eerste vraag is: Wat is één van uw symptomen? U kunt kiezen uit de volgende opties:
    hoofdpijn
    buikpijn'.
volgendeVraag(X):-
    X = 'Dankuwel. '.

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
volgendSymptoom([[Ziekte|Symptomen]|Ziektes],AlGevraagd,Symptoom):-
    (member(Symptoom,Symptomen),
    not(member(Symptoom,AlGevraagd)));
    volgendSymptoom(Ziektes,Algevraagd,Symptoom).
    

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


% ask for the next symptom
%ask([

diagnose:-
    maakData(Data),
    openingtext(T1),
    write(T1),
    eersteVraag(T2),
    write(T2),
    read(Symp1),
    zoekZiekte(Data,Symp1,NewData),
    volgendSymptoom(NewData,[],Symp2),
    write(Symp2).
    %ask(NewData,Symp2),
    %zoekZiekte(NewData,Symp1,NewData2),
    %write(NewData2).


