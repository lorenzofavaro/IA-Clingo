# Progetto Clingo
Questo progetto è stato realizzato per l'esame di Intelligenza Artificiale e Laboratorio del corso di Laurea Magistrale all'Università di Torino.

## Setup
- Installare [Clingo](https://github.com/potassco/clingo/releases/).
- Installare [VSCode](https://code.visualstudio.com/download) e l'apposita estensione [Answer Set Programming syntax highlighter](https://marketplace.visualstudio.com/items?itemName=abelcour.asp-syntax-highlight).
- Clonare il progetto.

## Il problema
Consultare il punto 2 del [testo di progetto](https://github.com/lorenzofavaro/IA-Clingo/blob/master/Testo%20Progetto.pdf)

## Struttura del progetto
- `parser` contiene le classi Java e i file di testo necessari a parsificare l'output restituito da `calendar.cl`.
  - `Slot.java` definisce un oggetto rappresentante il singolo slot di insegnamento.
  - `Parser.java` prende in input `raw_input.txt` e lo parsifica restituendo in output `parsed_output.txt`.
- `calendar.cl` definisce e risolve il problema della generazione del calendario degli insegnamenti

## Generazione del calendario
La Knowledge Base è stata popolata di tutti gli insegnamenti e da ulteriori fatti, necessari ad agevolare la definizione dei vari vincoli (rules) richiesti dal problema.
Il predicato principale è lo `slot/6`, il quale viene generato in ogni modello e contiene tutti i dati necessari di un insegnamento e della sua collocazione temporale. Infine, per assicurare la correttezza del calendario generato, è stato necessario definire alcuni vincoli.

Tutti i vincoli rigidi sono stati rispettati. Per quanto riguarda i vincoli auspicabili sono stati tutti definiti, tuttavia uno di essi, se presente, non permette di trovare alcun answer set. Ciò accade poichè il predicato è troppo generico e costringe Clingo ad esaminare un numero troppo elevato di possibili soluzioni. Prossimamente verrà riformulato.

## Risultati ottenuti

<table><thead> <tr> <th colspan="3">Settimana 1</th> </tr></thead><tbody> <tr> <td></td><td>Venerdì</td><td>Sabato</td></tr><tr> <td>9 - 11</td><td>Pre</td><td>aES</td></tr><tr> <td>11 - 13</td><td>aES</td><td>rDP</td></tr><tr> <td>13 - 14</td><td></td><td rowspan="3"></td></tr><tr> <td>14 - 16</td><td>aEISG</td></tr><tr> <td>16 - 18</td><td>aEISG</td></tr></tbody></table>

<table><thead><tr><th colspan="3">Settimana 2</th></tr></thead><tbody><tr><td></td><td>Venerdì</td><td>Sabato</td></tr><tr><td>9 - 11</td><td>rDP</td><td>aEISG</td></tr><tr><td>11 - 13</td><td>pBD</td><td>pBD</td></tr><tr><td>13 - 14</td><td></td><td rowspan="3"></td></tr><tr><td>14 - 16</td><td>aEISG</td></tr><tr><td>16 - 18</td><td>aEISG</td></tr></tbody></table>

<table><thead> <tr> <th colspan="7">Settimana 7</th> </tr></thead><tbody> <tr> <td></td><td>Lunedì<br></td><td>Martedì</td><td>Mercoledì</td><td>Giovedì</td><td>Venerdì</td><td>Sabato</td></tr><tr> <td>9 - 11</td><td>lM</td><td>pM</td><td>pBD</td><td>eFD</td><td>aUPM</td><td>pBD</td></tr><tr> <td>11 - 13</td><td>eFD</td><td>pM</td><td>lM</td><td>pBD</td><td>pM</td><td>pM</td></tr><tr> <td>13 - 14</td><td></td><td></td><td></td><td></td><td></td><td rowspan="3"></td></tr><tr> <td>14 - 16</td><td>pBD</td><td>aUPM</td><td>g3D</td><td>aUPM</td><td>g3D</td></tr><tr> <td>16 - 18</td><td>pBD</td><td>g3D<br></td><td>g3D</td><td>g3D</td><td>g3D</td></tr></tbody></table>

<table><thead> <tr> <th colspan="7">Settimana 16</th> </tr></thead><tbody> <tr> <td></td><td>Lunedì<br></td><td>Martedì</td><td>Mercoledì</td><td>Giovedì</td><td>Venerdì</td><td>Sabato</td></tr><tr> <td>9 - 11</td><td>sM</td><td>sM</td><td>cASM</td><td>sM</td><td>cASM</td><td>cPCP<br></td></tr><tr> <td>11 - 13</td><td>vGPDM</td><td>cASM</td><td>cASM</td><td>sM</td><td>gRU</td><td>cPCP</td></tr><tr> <td>13 - 14</td><td></td><td></td><td></td><td></td><td></td><td>aSLCW</td></tr><tr> <td>14 - 16</td><td>aESID</td><td>gQ</td><td>cPCP</td><td>cASM</td><td>vGPDM</td><td rowspan="2"></td></tr><tr> <td>16 - 18</td><td>aSLCW</td><td>gQ</td><td>vGPDM</td><td>cASM</td><td>gQ</td></tr></tbody></table>
