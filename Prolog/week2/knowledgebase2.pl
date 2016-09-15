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


% symptomen van mazelen. Bron: https://nl.wikipedia.org/wiki/Mazelen
mazelen verklaart koorts en hoesten en loopneus en ontstoken_ogen 
	en paarse_vlekjes en jeukende_vlekjes en uitslag en vlekjes.


% symptomen van roodvonk. Bron: https://nl.wikipedia.org/wiki/Roodvonk
roodvonk verklaart koorts en hoofdpijn en braken en aardbeientong 
	en frambozentong en verspreide_rode_puntjes en pijn en verhoging en darmklachten.


% symptomen van rode hond. Bron: https://nl.wikipedia.org/wiki/Rodehond
rode_hond verklaart verkoudheid en rozerode_vlekjes en verhoogde_temperatuur 
	en gewrichtspijn en verhoging en vlekjes en uitslag en pijn.


% symptomen van bof. Bron: https://nl.wikipedia.org/wiki/Bof
bof verklaart dikker_wordende_wangen en blindheid en doofheid 
	en ontsteking en ontsteking_van_alvleesklier 
	en ontsteking_van_eileider en ontsteking_van_testikel
	en ontsteking.


% symptomen van waterpokken. Bron: https://nl.wikipedia.org/wiki/Waterpokken
waterpokken verklaart koorts en blaasjes_op_een_rode_ondergrond 
	en verkoudheid en rode_vlekjes en verhoging en vlekjes en uitslag.


% symptomen van de ziekte van Filatov-Dukes. Bron: https://tallsay.com/page/4294972763/kinderziektes-de-vierde-ziekte-beschrijving-oorzaak-symptomen-en-behandeling
ziekte_van_Filatov_Dukes verklaart koorts en hoofdpijn 
	en keelpijn en braken en diarree en misselijkheid 
	en verhoging en pijn en darmklachten.


% symptomen van parotitis. Bron: https://nl.wikipedia.org/wiki/Vijfde_ziekte
parotitis verklaart diarree en oorontsteking 
	en opgezette_lymfeknopen en uitslag en hoge_koorts 
	en koorts en verhoging en ontsteking en darmklachten.


% symptomen van infectiosum. Bron: https://nl.wikipedia.org/wiki/Zesde_ziekte
infectiosum verklaart grote_en_kleine_vlekjes_door_elkaar 
	en gewrichtspijn en branderige_vlekjes en verhoging 
	en pijn en vlekjes en uitslag.


% specificaties van symptomen
rozerode_vlekjes verklaart rozerode_vlekjes_op_het_gezicht en rozerode_vlekjes_achter_de_oren.

blaasjes_op_een_rode_ondergrond verklaart kleine_met_vocht_gevulde_blaasjes_op_een_rode_ondergrond.

verhoging verklaart lichte_verhoging en koorts en verhoogde_temperatuur.

koorts verklaart hoge_koorts en koortsstuipen.

ontsteking verklaart ontstoken_ogen en ontsteking_van_eileider 
	en ontsteking_van_testikel en ontsteking_van_alvleesklier en oorontsteking.

vlekjes verklaart rozerode_vlekjes en rode_vlekjes 
	en paarse_vlekjes en jeukende_vlekjes en branderige_vlekjes.

uitslag verklaart vlekjes en blaasjes_op_een_rode_ondergrond en verspreide_rode_puntjes.

paarse_vlekjes verklaart licht_jeukende_paarse_vlekjes.
jeukende_vlekjes verklaart licht_jeukende_paarse_vlekjes.

% splitRule(X verklaart Y):-
%	lijst maken,
%		splitRule(A en B).


test(Symptoom en Symptomen, X):-
	append([Symptoom], [Symptomen], X).

maakSymptomenLijst([], _).

maakSymptomenLijst(Symptoom en Symptomen, SL):-
	maakSymptomenLijst(Symptomen, [Symptoom], SL).

maakSymptomenLijst(Symptoom, SL):-
	append([Symptoom], SL, NSL),
	maakSymptomenLijst([], NSL).

maakSymptomenLijst(Symptoom en Symptomen, SL, NSL):-
	append([Symptoom], SL, NSL),
	maakSymptomenLijst(Symptomen, NSL).





