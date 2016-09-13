% Opdracht 2 Micha de Groot en Kaj Meijer


openingtext(X):-
    X = 'Welkom bij onze diagnoseprogramma. We gaan u zo een aantal vragen stellen over uw symptomen. Beantwoord de vragen door het antwoord te typen in kleine letters met een punt er achter alstublieft.\n'.

eersteVraag(X):-
    X = 'De eerste vraag is: Wat is één van uw symptomen? U kunt kiezen uit de volgende opties:
    hoofdpijn
    buikpijn'.

maakData([[mazelen,[hoofdpijn,buikpijn]],[rode_hond,[hoofdpijn,misselijk]]]).

zoekZiekte([Ee
matchZiekte([Ziekte, Symptomen],Symptoom,Lijst):-
    (member(Symptoom,Symptomen),
    delete(Symptomen,Symptoom,SymptomenNew),
    Lijst = [Ziekte,SymptomenNew]);
    (not(member(Symptoom,Symptomen)),
    Lijst = []).

    

diagnose:-
    maakData(Data),
    openingtext(T1),
    write(T1),
    eersteVraag(T2),
    write(T2),
    read(Symp1),
    zoekZiekte(Data,Symp1,newData),
    write(newData).


