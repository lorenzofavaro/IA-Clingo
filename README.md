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
  - `Parser.java` prende in input `output.txt` e lo parsifica restituendo in output `parsed_output.txt`.
- `calendar.cl` definisce e risolve il problema della generazione del calendario degli insegnamenti

## Generazione del calendario
La Knowledge Base è stata popolata di tutti gli insegnamenti e da ulteriori fatti, necessari ad agevolare la definizione dei vari vincoli (rules) richiesti dal problema.
Il predicato principale è lo `slot/6`, il quale viene generato in ogni modello e contiene tutti i dati necessari di un insegnamento e della sua collocazione temporale. Infine, per assicurare la correttezza del calendario generato, è stato necessario definire alcuni vincoli.

Tutti i vincoli rigidi sono stati rispettati. Per quanto riguarda i vincoli auspicabili sono stati tutti definiti, tuttavia uno di essi, se presente, non permette di trovare alcun answer set. Ciò accade poichè il predicato è troppo generico e costringe Clingo ad esaminare un numero troppo elevato di possibili soluzioni. Prossimamente verrà riformulato.

## Risultati ottenuti

