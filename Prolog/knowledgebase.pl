% operators die we moeten toevoegen
:- op(250, xfy, of).
:- op(300, xfy, en).
:- op(800, fx, als).
:- op(700, xfy, dan).
:- op(100, fy, niet).




% symptomen van mazelen. Bron: wikipedia
koorts als mazelen.
hoesten als mazelen.
loopneus als mazelen.
ontstoken_ogen als mazelen.
paarse_vlekjes als mazelen.
jeukende_vlekjes als mazelen.
vlekjes als mazelen.
uitslag als mazelen.
verhoging als mazelen.
ontsteking als mazelen.


% symptomen van roodvonk. Bron: wikipedia
koorts als roodvonk.
hoofdpijn als roodvonk.
braken als roodvonk.
aardbeientong als roodvonk.
frambozentong als roodvonk.
verspreide_rode_puntjes als roodvonk.
uitslag als roodvonk.
pijn als roodvonk.
darmklachten als roodvonk.



% symptomen van rode hond. Bron: wikipedia
verkoudheid als rode_hond.
rozerode_vlekjes als rode_hond.
verhoogde_temperatuur als rode_hond.
gewrichtspijn als rode_hond.
verhoging als rode_hond.
vlekjes als rode_hond.
uitslag als rode_hond.
pijn als rode_hond.


% symptomen van bof. Bron: wikipedia
dikker_wordende_wangen als bof.
blindheid als bof.
doofheid als bof.
ontsteking_van_alvleesklier als bof.
ontsteking_van_eileider als bof.
ontsteking_van_testikel als bof.
ontsteking als bof.


% symptomen van waterpokken. Bron: wikipedia
koorts als waterpokken.
blaasjes_op_een_rode_ondergrond als waterpokken.
verkoudheid als waterpokken.
rode_vlekjes als waterpokken.
verhoging als waterpokken.
vlekjes als waterpokken.
uitslag als waterpokken.


% symptomen van de ziekte van Filatov-Dukes. Bron: https://tallsay.com/page/4294972763/kinderziektes-de-vierde-ziekte-beschrijving-oorzaak-symptomen-en-behandeling
koorts als ziekte_van_Filatov_Dukes.
hoofdpijn als ziekte_van_Filatov_Dukes.
keelpijn als ziekte_van_Filatov_Dukes.
braken als ziekte_van_Filatov_Dukes.
diarree als ziekte_van_Filatov_Dukes.
misselijkheid als ziekte_van_Filatov_Dukes.
verhoging als ziekte_van_Filatov_Dukes.
pijn als ziekte_van_Filatov_Dukes.


% symptomen van parotitis. Bron: wikipedia
diarree als parotitis.
oorontsteking als parotitis.
opgezette_lymfeknopen als parotitis.
uitslag als parotitis.
hoge_koorts als parotitis.
koorts als parotitis.
verhoging als parotitis.
darmklachten als parotitis.


% symptomen van infectiosum. Bron: wikipedia
grote_en_kleine_vlekjes_door_elkaar als infectiosum.
gewrichtspijn als infectiosum.
branderige_vlekjes als infectiosum.
verhoging als infectiosum.
uitslag als infectiosum.
vlekjes als infectiosum.
pijn als infectiosum.


% specificaties van symptomen
rozerode_vlekjes_op_het_gezicht als rozerode_vlekjes.
rozerode_vlekjes_achter_de_oren als rozerode_vlekjes.
kleine_met_vocht_gevulde_blaasjes_op_een_rode_ondergrond als blaasjes_op_een_rode_ondergrond.

lichte_verhoging als verhoging.
koorts als verhoging.
verhoogde_temperatuur als verhoging.

hoge_koorts als koorts.
koortsstuipen als koorts.

ontstoken_ogen als ontsteking.
oorontsteking als ontsteking.
ontsteking_van_eileider als ontsteking.
ontsteking_van_testikel als ontsteking.
ontsteking_van_alvleesklier als ontsteking.

rozerode_vlekjes als vlekjes.
rode_vlekjes als vlekjes.
paarse_vlekjes als vlekjes.
jeukende_vlekjes als vlekjes.
branderige_vlekjes als vlekjes.
grote_en_kleine_vlekjes_door_elkaar als vlekjes.

vlekjes als uitslag.
blaasjes_op_een_rode_ondergrond als uitslag.
verspreide_rode_puntjes als uitslag.

licht_jeukende_paarse_vlekjes als paarse_vlekjes.
licht_jeukende_paarse_vlekjes als jeukende_vlekjes.

hoofdpijn als pijn.
gewrichtspijn als pijn.
keelpijn als pijn.
branderige_vlekjes als pijn.

diarree als darmklachten.
braken als darmklachten.
misselijkheid als darmklachten.