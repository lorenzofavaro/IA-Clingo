% Docente, Corso, Ore

insegnamento(
    muzzetto, pM, 14;
    pozzato, fIPP, 14;
    gena, lM, 20;
    tomatis, gQ, 10;
    micalizio, aSLCW, 20;
    terranova, pGDI, 10;
    mazzei, pBD, 20;
    giordani, sMISM, 14;
    zanchetta, aEISG, 14;
    gena, aUPM, 14;
    muzzetto, mD, 10;
    vargiu, eFD, 10;
    boniolo, rDP, 10;
    damiano, tSSW, 20;
    zanchetta, tSMD, 10;
    suppini, iSMM, 14;
    valle, aES, 10;
    ghidelli, aESID, 20;
    gabardi, cPCP, 14;
    santangelo, sM, 10;
    taddeo, cASM, 20;
    gribaudo, g3D, 20;
    pozzato, pSAWDM1, 10;
    schifanella, pSAWDM2, 10;
    lombardo, gRU, 10;
    travostino, vGPDM, 10;
    docente, recupero, 4;
    tuttiDocenti, presentazione, 2;
).

% Settimana
settimana(1..24).
settimanaSpeciale(7; 16).

% Giorni
giorno(1; 2; 3; 4).

% Prima settimana, primo giorno, prima lezione
primaLezione(1,5,9,11).

% Orari
orarioFullTime(9, 11; 11, 13; 14, 16; 16, 18).
orarioSabato(9, 11; 11, 13).
orarioSabatoUltimaOra(13, 14).

% Propedeuticità
propedeutico(fIPP, aSLCW).
propedeutico(aSLCW, pSAWDM1).
propedeutico(pSAWDM1, pSAWDM2).
propedeutico(pBD, tSSW).
propedeutico(lM, aSLCW).
propedeutico(pM, mD).
propedeutico(mD, tSMD).
propedeutico(pM, sMISM).
propedeutico(pM, pGDI).
propedeutico(aEISG, eFD).
propedeutico(eFD, aESID).
propedeutico(aEISG, g3D).

propedeuticoAuspicabile(fIPP, pBD).
propedeuticoAuspicabile(tSMD, iSMM).
propedeuticoAuspicabile(cPCP, gRU).
propedeuticoAuspicabile(tSSW, pSAWDM1).

% Slot lezioni nelle settimane 7 e 16, da lunedi a giovedi
1 { slot(Settimana, Giorno, Inizio, Fine, Corso, Docente) : insegnamento(Docente, Corso, _) } 1 :-
    settimana(Settimana), giorno(Giorno), orarioFullTime(Inizio, Fine), settimanaSpeciale(Settimana).

% Slot lezioni in tutte le settimane, solo venerdi
1 { slot(Settimana, 5, Inizio, Fine, Corso, Docente) : insegnamento(Docente, Corso, _) } 1 :-
    settimana(Settimana), orarioFullTime(Inizio, Fine), not primaLezione(Settimana, 5, Inizio, Fine).

% Slot lezioni in tutte le settimane, solo sabato
1 { slot(Settimana, 6, Inizio, Fine, Corso, Docente) : insegnamento(Docente, Corso, _) } 1 :-
    settimana(Settimana), orarioSabato(Inizio, Fine).
0 { slot(Settimana, 6, 13, 14, Corso, Docente) : insegnamento(Docente, Corso, _) } 1 :-
    settimana(Settimana).

% Slot prima lezione (presentazione)
slot(1, 5, 9, 11, presentazione, tuttiDocenti).

% --------------
% VINCOLI RIGIDI
% --------------

% 1) Tutti gli insegnamenti devono essere presenti nelle ore stabilite
conteggio_slot_interi(Corso, Conteggio) :-
    Conteggio = #count{ Settimana, Giorno, Inizio, Fine : slot(Settimana, Giorno, Inizio, Fine, Corso, _), Inizio != 13, Fine != 14 },
    slot(_, _, _, _, Corso, _).

conteggio_slot_meta(Corso, Conteggio) :-
    Conteggio = #count{ Settimana, Giorno, Inizio, Fine : slot(Settimana, Giorno, Inizio, Fine, Corso, _), Inizio == 13, Fine == 14 },
    slot(_, _, _, _, Corso, _).

conteggio_slot_totali(Corso, Conteggio) :-
    conteggio_slot_interi(Corso, Conteggio1), conteggio_slot_meta(Corso, Conteggio2), Conteggio = Conteggio1 * 2 + Conteggio2.

:- conteggio_slot_totali(Corso, Conteggio1), insegnamento(_, Corso, Conteggio2), Conteggio1 != Conteggio2.

% 2) A ciascun corso vengono assegnate minimo 2 (implicito negli orari) e massimo 4 ore nello stesso giorno, ossia non ci possono essere più di 2 lezioni dello stesso corso
conteggioOrePerCorso(Conteggio, Corso, Settimana, Giorno) :-
    Conteggio = #count { Inizio, Fine : slot(Settimana, Giorno, Inizio, Fine, Corso, _)},
    slot(Settimana, Giorno, _, _, Corso, _).

:- conteggioOrePerCorso(Conteggio, _, _, _), Conteggio > 2.

% 3) La prima lezione dell'insegnamento "aUPM" deve essere collocata prima che siano terminate le lezioni dell'insegnamento "lM"
slot_precedente(Corso1, Corso2) :- slot(S1, _, _, _, Corso1, _), slot(S2, _, _, _, Corso2, _), S1 < S2.
slot_precedente(Corso1, Corso2) :- slot(S, G1, _, _, Corso1, _), slot(S, G2, _, _, Corso2, _), G1 < G2.
slot_precedente(Corso1, Corso2) :- slot(S, G, I1, _, Corso1, _), slot(S, G, I2, _, Corso2, _), I1 < I2.

:- not slot_precedente(aUPM, lM).

% 4) L'insegnamento "Project Management" deve concludersi non oltre la prima settimana full-time
:- slot(S, _, _, _, pM, _), S > 7.

% 5) Vincoli di propedeuticità
primaLezione(Corso, S, G, I):-
    S = #min{S1 : slot(S1, _, _, _, Corso, _)}, slot(_, _, _, _, Corso, _),
    G = #min{G1 : slot(S, G1, _, _, Corso, _)}, slot(S, _, _, _, Corso, _),
    I = #min{I1 : slot(S, G, I1, _, Corso, _)}, slot(S, G, _, _, Corso, _).

ultimaLezione(Corso, S, G, I):-
    S = #max{S1 : slot(S1, _, _, _, Corso, _)}, slot(_, _, _, _, Corso, _),
    G = #max{G1 : slot(S, G1, _, _, Corso, _)}, slot(S, _, _, _, Corso, _),
    I = #max{I1 : slot(S, G, I1, _, Corso, _)}, slot(S, G, _, _, Corso, _).

precede(Corso1, Corso2) :- ultimaLezione(Corso1, S1, _, _), primaLezione(Corso2, S2, _, _), S1 < S2.
precede(Corso1, Corso2) :- ultimaLezione(Corso1, S, G1, _), primaLezione(Corso2, S, G2, _), G1 < G2.
precede(Corso1, Corso2) :- ultimaLezione(Corso1, S, G, I1), primaLezione(Corso2, S, G, I2), I1 < I2.

:- propedeutico(Corso1, Corso2), not precede(Corso1, Corso2).

% 6) Le 4 ore di recupero devono essere suddivise in 2 blocchi da 2 ore, quindi una lezione di recupero non può essere di sabato dalle 13 alle 14
:- slot(_,_,13,14,recupero,_).

% -------------------
% VINCOLI AUSPICABILI
% -------------------

% 1) La distanza tra la prima e l'ultima lezione di ciascun insegnamento non deve superare le 6 settimane
:- primaLezione(Corso, Settimana1, _, _), ultimaLezione(Corso, Settimana2, _, _), |Settimana1 - Settimana2| > 5.

% 2) La prima lezione degli insegnamenti "cASM" e "iSMM" devono essere collocate nella seconda settimana full-time
:- slot(Settimana, _, _, _, cASM, _), Settimana < 16.
:- slot(Settimana, _, _, _, iSMM, _), Settimana < 16.

% 3) Vincoli di propedeuticità
% precedente(S1, G1, I1, S2, G2, I2):- num(S1), num(G1), num(I1), num(S2), num(G2), num(I2), S1*100+G1*10+I1 < S2*100+G2*10+I2.

% conteggioSlotPrecedenti(Corso1, Corso2, Conteggio) :-
%     primaLezione(Corso2, S2, G2, I2),
%     Conteggio = #count{S1,G1,I1,F1 : slot(S1, G1, I1, F1, Corso1, _), precedente(S1, G1, I1, S2, G2, I2)},
%     slot(_, _, _, _, Corso1, _).

% :- propedeuticoAuspicabile(Corso1, Corso2), conteggioSlotPrecedenti(Corso1, Corso2, Conteggio), Conteggio != 2.

% 4) La distanza fra l'ultima lezione di "pSAWDM1" e la prima di "pSAWDM2" non deve superare le due settimane
:- ultimaLezione(pSAWDM1, Settimana1, _, _), primaLezione(pSAWDM2, Settimana2, _, _), |Settimana1 - Settimana2| > 2. 

#show slot/6.
% #show conteggioOrePerDocente/4.
% #show conteggioOrePerCorso/4.
% #show conteggio_slot_interi/2.
%#show conteggio_slot_meta/2.
% #show insegnamento/3.
% #show primaLezione/4.
% #show precede/2.
