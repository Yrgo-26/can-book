# CAN - bussen, framen och kontrollern
En kort bok om CAN, sammansatt med LuaLaTeX. Den beskriver protokollet: bussen, framen,
bitstoppningen, checksumman, arbitreringen, bittajmingen och felhanteringen. Sista kapitlet
beskriver den förenklade kontroller som byggs i undervisningen, vad den implementerar av allt
det, och vad den medvetet låter bli.

Boken är skriven för **båda hållen** av ett CAN-system: den som bygger kontrollern i hårdvara och
den som skriver drivrutinen i mjukvara. Den nämner därför varken kurs eller klass.

*The book is also available in English: [CAN - the bus, the frame and the controller](./en/can-en.pdf).
See [`en/`](./en/README.md).*

---

## Boken
Boken finns i två språkupplagor med samma innehåll:
* Svenska: **[CAN - bussen, framen och kontrollern (can-sv.pdf)](./sv/can-sv.pdf)**.
* Engelska: **[CAN - the bus, the frame and the controller (can-en.pdf)](./en/can-en.pdf)**.

De byggda PDF:erna är incheckade i repot och går att läsa direkt på GitHub.

```text
sv/    Svenska upplagan, can-sv.pdf
en/    Engelska upplagan, can-en.pdf
```

Upplagorna är samma bok, kapitel för kapitel och etikett för etikett: sju kapitel och ett appendix
med svaren. Varje upplaga har sina egna källor, figurer inräknade, så en rättelse i prosan eller en
ändring i en figur behöver göras i båda.

I båda upplagorna är all kod och alla signalnamn på engelska. Detaljerna står i upplagornas egna
README: [`sv/`](./sv/README.md) och [`en/`](./en/README.md).

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
make                 # bygger båda upplagorna
make sv              # bara den svenska, sv/can-sv.pdf
make en              # bara den engelska, en/can-en.pdf
make VERSION=v2      # samma, med versionen på titelsidan
make clean           # tar bort allt byggena skriver
```

Varje upplaga har en egen Makefile och byggs på samma sätt; rotens Makefile skickar bara vidare
arbetet.

Bygget kräver **LuaLaTeX** med TeX Gyre-typsnitten, DejaVu Sans Mono och paketen `babel`,
`tcolorbox`, `listings`, `titlesec`, `booktabs` och `tikz`. På Ubuntu/WSL räcker:

```bash
sudo apt -y install texlive-luatex texlive-latex-extra texlive-fonts-extra texlive-lang-european
```

`texlive-lang-european` behövs för båda upplagorna: den bär den svenska avstavningen, och den
engelska upplagan har svenska som andraspråk för den svenska upplagans titel.

Två pass körs alltid, det andra för innehållsförteckningen och referenserna. Bygget fallerar om
någon referens är odefinierad.

---

## Ge ut en ny upplaga

PDF:erna är incheckade i repot, så de går att läsa direkt på GitHub. En skarp upplaga publiceras
dessutom som en release: pusha en versionstagg.

```bash
git tag v1.1.0
git push origin v1.1.0
```

[Book-arbetsflödet](./.github/workflows/book.yml) bygger då båda PDF:erna med taggen på titelsidan
och lägger upp dem i en release med samma namn.

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
Bokens text och figurer, i båda upplagorna, och PDF:erna som byggs från dem, är licensierade under
[CC BY 4.0](./LICENSE) – Erik Pihl. Det gäller även bokens byggfiler: `Makefile` i roten, och
`canbook.sty`, `canbook.lua` och `Makefile` i `sv/` och `en/`.

---
