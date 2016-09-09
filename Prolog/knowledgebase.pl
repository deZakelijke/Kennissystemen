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

% symptomen van roodvonk.
koorts als roodvonk.
hoofdpijn als roodvonk.
braken als roodvonk.
aardbeientong of frambozentong als roodvonk.

% Symptomen van rode hond
verkoudheid als rode_hond.
rozerode_vlekjes als rode_hond.

% symptomen van bof
dikker_wordende_wangen als bof.

%symptomen van waterpokken
koorts als waterpokken.
blaasjes_op_een_rode_ondergrond als waterpokken.


% specificaties van symptomen
rozerode_vlekjes_op_het_gezicht als rozerode_vlekjes.
rozerode_vlekjes_achter_de_oren als rozerode_vlekjes.
kleine_met_voct_gevulde_blaasjes_op_een_rode_ondergrond als blaasjes_op_een_rode_ondergrond.

