# Boken, svenska upplagan
CAN som protokoll, satt som bok med LuaLaTeX: sju kapitel och ett appendix med svaren på samtliga
övningar.

Den här upplagan är på svenska. All kod, alla registernamn och alla signalnamn är på engelska,
precis som i koden och i de gemensamma specifikationerna. Den engelska upplagan ligger i
[`../en/`](../en/README.md) och är samma bok, kapitel för kapitel och etikett för etikett.

**[Läs boken (can-sv.pdf)](./can-sv.pdf)**

---

## Att bygga den

```bash
sudo apt -y install texlive-luatex texlive-latex-extra texlive-fonts-extra texlive-lang-european
make -C sv                # Skriver sv/can-sv.pdf, daterad i dag.
make -C sv VERSION=v2     # Detsamma, med versionen på titelsidan.
make -C sv clean          # Tar bort sv/build/ och PDF:en.
make                      # Bygger båda upplagorna, svenska och engelska.
```

Bygget kör LuaLaTeX två gånger, så att innehållsförteckningen och korsreferenserna sätter sig, och
fallerar om en referens lämnats odefinierad.

`texlive-lang-european` är inte valfri: den bär `babel`s svenska stöd, som ger "Kapitel",
"Innehåll", "Figur" och den svenska avstavningen.

---

## Vad som ligger var

```text
book.tex          Dokumentets rot: vilka kapitel som ingår, i vilken ordning
canbook.sty       All design - typsnitt, färger, rubriker, kodblock, övningar, svar
canbook.lua       Hjälpfunktionen \code{} behöver för att sätta kod ordagrant
front/            Titelsida och förord
chapters/NN/      Ett kapitel per katalog
back/answers/     Svaren på övningarna
figures/          Figurerna, ritade i TikZ
build/            Byggkatalog; skapas av make och versionshanteras inte
```

Boken läser ingenting utanför sin egen katalog. Figurerna ritas i TikZ i samma färger och typsnitt
som sidan, och koden i texten är en satt kopia --- en ändring i kursmaterialet når alltså boken
först när motsvarande `.tex`-fil ändras.

---

## Att lägga till ett kapitel
1. Skapa `chapters/NN/chapter.tex` med `\chapter{...}` och ett `\label{ch:...}`.
2. Lägg till `\input{chapters/NN/chapter}` i `book.tex`.
3. Lägg övningarna sist i kapitlet, med `\exercise{Titel}{Sort}` och ett `\label{ex:NN:M}`.
4. Lägg svaren i `back/answers/chapter.tex`, med `\solution{ex:NN:M}{Titel}`.

Referenser mellan kapitel skrivs `\kapref{ch:...}`, aldrig med ett hårdkodat kapitelnummer.

Gör samma ändring i den engelska upplagan, med samma etiketter. Makronamnen är desamma i båda
upplagorna, så en korsreferens kan kopieras ordagrant mellan dem.

---

## Licens
Bokens text och figurer, och PDF:en som byggs från dem, är licensierade under
[CC BY 4.0](../LICENSE) – Erik Pihl. Det gäller även den här katalogens byggfiler: `canbook.sty`,
`canbook.lua` och `Makefile`.
