% Knowledge base van Micha de Groot-10434410 en Kaj Meijer-10509534
% studie@michadegroot.nl en k.d.meijer17@gmail.com
% Kennissystemen 2016 eerste opdracht

% operators die we moeten toevoegen
:- op(250, xfy, of).
:- op(300, xfy, en).
:- op(700, xfy, impliceert).
:- op(800, xfx, dubbel_impliceert).
:- op(100, fy, niet).

of(A,B):-
    A;
    B.

en(A,B):-
    A,
    B.

impliceert(A,B):- A,B.
impliceert(A,_):- niet(A).

dubbel_impliceert(A,B):-
    impliceert(A,B),
    impliceert(B,A).

niet(A):-
    \+A.


% symptomen van mazelen. Bron: https://nl.wikipedia.org/wiki/Mazelen
koorts impliceert mazelen.
koorts impliceert mazelen.
hoesten impliceert mazelen.
loopneus impliceert mazelen.
ontstoken_ogen impliceert mazelen.
paarse_vlekjes impliceert mazelen.
jeukende_vlekjes impliceert mazelen.


% symptomen van roodvonk. Bron: https://nl.wikipedia.org/wiki/Roodvonk
koorts impliceert roodvonk.
hoofdpijn impliceert roodvonk.
braken impliceert roodvonk.
aardbeientong of frambozentong impliceert roodvonk.
verspreide_rode_puntjes impliceert roodvonk.



% symptomen van rode hond. Bron: https://nl.wikipedia.org/wiki/Rodehond
verkoudheid impliceert rode_hond.
rozerode_vlekjes impliceert rode_hond.
verhoogde_temperatuur impliceert rode_hond.
gewrichtspijn impliceert rode_hond.
verhoging impliceert rode_hond.
vlekjes impliceert rode_hond.
uitslag impliceert rode_hond.


% symptomen van bof. Bron: https://nl.wikipedia.org/wiki/Bof
dikker_wordende_wangen impliceert bof.
blindheid impliceert bof.
doofheid impliceert bof.
ontsteking_van_alvleesklier impliceert bof.
ontsteking_van_eileider impliceert bof.
ontsteking_van_testikel impliceert bof.
ontsteking impliceert bof.


% symptomen van waterpokken. Bron: https://nl.wikipedia.org/wiki/Waterpokken
koorts impliceert waterpokken.
blaasjes_op_een_rode_ondergrond impliceert waterpokken.
verkoudheid impliceert waterpokken.
rode_vlekjes impliceert waterpokken.
verhoging impliceert waterpokken.


% symptomen van de ziekte van Filatov-Dukes. Bron: https://tallsay.com/page/4294972763/kinderziektes-de-vierde-ziekte-beschrijving-oorzaak-symptomen-en-behandeling
koorts impliceert ziekte_van_Filatov_Dukes.
hoofdpijn impliceert ziekte_van_Filatov_Dukes.
keelpijn impliceert ziekte_van_Filatov_Dukes.
braken impliceert ziekte_van_Filatov_Dukes.
diarree impliceert ziekte_van_Filatov_Dukes.
misselijkheid impliceert ziekte_van_Filatov_Dukes.
verhoging impliceert ziekte_van_Filatov_Dukes.


% symptomen van parotitis. Bron: https://nl.wikipedia.org/wiki/Vijfde_ziekte
diarree impliceert parotitis.
oorontsteking impliceert parotitis.
opgezette_lymfeknopen impliceert parotitis.
uitslag impliceert parotitis.
hoge_koorts impliceert parotitis.
koorts impliceert parotitis.
verhoging impliceert parotitis.


% symptomen van infectiosum. Bron: https://nl.wikipedia.org/wiki/Zesde_ziekte
grote_en_kleine_vlekjes_door_elkaar impliceert infectiosum.
gewrichtspijn impliceert infectiosum.
branderige_vlekjes impliceert infectiosum.
verhoging impliceert infectiosum.


% specificaties van symptomen
rozerode_vlekjes_op_het_gezicht impliceert rozerode_vlekjes.
rozerode_vlekjes_achter_de_oren impliceert rozerode_vlekjes.
kleine_met_vocht_gevulde_blaasjes_op_een_rode_ondergrond impliceert blaasjes_op_een_rode_ondergrond.

lichte_verhoging impliceert verhoging.
koorts impliceert verhoging.
verhoogde_temperatuur impliceert verhoging.

hoge_koorts impliceert koorts.
koortsstuipen impliceert koorts.

ontstoken_ogen impliceert ontsteking.
oorontsteking impliceert ontsteking.
ontsteking_van_eileider impliceert ontsteking.
ontsteking_van_testikel impliceert ontsteking.
ontsteking_van_alvleesklier impliceert ontsteking.

rozerode_vlekjes impliceert vlekjes.
rode_vlekjes impliceert vlekjes.
paarse_vlekjes impliceert vlekjes.
jeukende_vlekjes impliceert vlekjes.
branderige_vlekjes impliceert vlekjes.

vlekjes impliceert uitslag.
blaasjes_op_een_rode_ondergrond impliceert uitslag.
verspreide_rode_puntjes impliceert uitslag.

licht_jeukende_paarse_vlekjes impliceert paarse_vlekjes.
licht_jeukende_paarse_vlekjes impliceert jeukende_vlekjes.



