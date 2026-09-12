# CAN - bussen, framen och kontrollern
En kort bok om CAN, sammansatt med LuaLaTeX. Den beskriver protokollet: bussen, framen,
bitstoppningen, checksumman, arbitreringen, bittajmingen och felhanteringen. Sista kapitlet
beskriver den förenklade kontroller som byggs i undervisningen, vad den implementerar av allt
det, och vad den medvetet låter bli.

Boken är skriven för **båda hållen** av ett CAN-system: den som bygger kontrollern i hårdvara och
den som skriver drivrutinen i mjukvara. Den nämner därför varken kurs eller klass.

Brödtexten är på svenska, all kod och alla signalnamn på engelska.

**[Läs boken (can.pdf)](./can.pdf)** --- den byggda PDF:en är incheckad i repot och går att läsa
direkt på GitHub.

---

## Innehåll

| Kapitel | Ämne |
|---|---|
| 1 | Bussen: topologi, dominant/recessiv, wired-AND, terminering |
| 2 | Framen: fälten, identifieraren, RTR, DLC, kvittensen |
| 3 | Bitstoppning och CRC-15 |
| 4 | Arbitrering, bit för bit |
| 5 | Bittajming och synkronisering |
| 6 | Felhantering: felframes, felräknare, bus off |
| 7 | Den förenklade kontrollern, och de tre begränsningar som når upp i mjukvaran |
| Appendix A | Svar på samtliga övningar |

Varje kapitel slutar med fyra övningar. Alla görs med papper och penna, och alla besvaras i
appendix A.

---

## Bygga

```bash
make                 # bygger can.pdf
make VERSION=v2      # samma, med versionen på titelsidan
make clean           # tar bort allt bygget skriver
```

Bygget kräver **LuaLaTeX** med TeX Gyre-typsnitten, DejaVu Sans Mono och paketen `babel`
(svenska), `tcolorbox`, `listings`, `titlesec`, `booktabs` och `tikz`. På Ubuntu/WSL räcker:

```bash
sudo apt -y install texlive-luatex texlive-latex-extra texlive-fonts-extra texlive-lang-european
```

Två pass körs alltid, det andra för innehållsförteckningen och referenserna. Bygget fallerar om
någon referens är odefinierad.

---

## Struktur

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

Boken läser ingenting utanför `book/`. Figurerna ritas i TikZ i samma färger och typsnitt som
sidan, och koden i texten är en satt kopia --- en ändring i kursmaterialet når alltså boken först
när motsvarande `.tex`-fil ändras.

---

## Att lägga till ett kapitel
1. Skapa `chapters/NN/chapter.tex` med `\chapter{...}` och ett `\label{ch:...}`.
2. Lägg till `\input{chapters/NN/chapter}` i `book.tex`.
3. Lägg övningarna sist i kapitlet, med `\exercise{Titel}{Sort}` och ett `\label{ex:NN:M}`.
4. Lägg svaren i `back/answers/chapter.tex`, med `\solution{ex:NN:M}{Titel}`.

Referenser mellan kapitel skrivs `\kapref{ch:...}`, aldrig med ett hårdkodat kapitelnummer.

---

## Ge ut en ny upplaga

PDF:en är incheckad i repot, så den går att läsa direkt på GitHub. En skarp upplaga publiceras
dessutom som en release: pusha en versionstagg.

```bash
git tag v1.1.0
git push origin v1.1.0
```

[Book-arbetsflödet](./.github/workflows/book.yml) bygger då PDF:en med taggen på titelsidan och
lägger upp den i en release med samma namn.

Boken ska kunna användas i många år, så ingen sida i den nämner en klass, ett år eller ett datum;
titelsidan visar versionen, och byggdatumet bara när ingen version anges.

---

## Vilka kurser boken används i
Boken är gemensam för de två kurser som bygger var sin halva av en CAN-nod, och nämner därför
varken kurs eller klass:
* [Programmerbar logik](https://github.com/Yrgo-26/programmable-logic) - bygger CAN-kontrollern i VHDL. För dem är kapitel 1-6
  kravspecifikationen, bit för bit.
* [Kommunikationsprotokoll & IoT](https://github.com/Yrgo-26/iot) - skriver C++-drivrutinen mot den. För dem är boken
  bakgrunden till kursbokens CAN-kapitel, och kapitel 7 det som kommer till användning vid
  felsökning.

Registerkartan och SPI-protokollet - kontraktet mellan de två - hör till hårdvarukursen och står
inte här; se [Yrgo-26/programmable-logic](https://github.com/Yrgo-26/programmable-logic).

---

## Licens
Bokens text och figurer, och PDF:en som byggs från dem, är licensierade under
[CC BY 4.0](./LICENSE) – Erik Pihl. Det gäller även bokens byggfiler: `canbook.sty`,
`canbook.lua` och `Makefile`.

---
