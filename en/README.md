# The book, English edition
CAN as a protocol, typeset as a book with LuaLaTeX: seven chapters and an appendix with the answers
to every exercise.

This edition is in English, and so are all the code, all the register names and all the signal
names, exactly as in the code and in the shared specifications. The Swedish edition is in
[`../sv/`](../sv/README.md) and is the same book, chapter for chapter and label for label, so a
correction to either has to be made in both.

**[Read the book (can-en.pdf)](./can-en.pdf)**

---

## Building it

```bash
sudo apt -y install texlive-luatex texlive-latex-extra texlive-fonts-extra texlive-lang-european
make -C en                # Writes en/can-en.pdf, dated today.
make -C en VERSION=v2     # The same, with the version on the title page.
make -C en clean          # Removes en/build/ and the PDF.
make                      # Builds both editions, Swedish and English.
```

The build runs LuaLaTeX twice, so that the contents and the cross-references settle, and fails if a
reference has been left undefined.

`texlive-lang-european` is not optional even here: `babel` is loaded with Swedish as a second
language, for the Swedish edition's title on the copyright page, which stays in Swedish.

---

## What lives where

```text
book.tex          The document's root: which chapters are included, in what order
canbook.sty       All of the design - fonts, colours, headings, code blocks, exercises, answers
canbook.lua       The helper \code{} needs to typeset code verbatim
front/            Title page and preface
chapters/NN/      One chapter per directory
back/answers/     The answers to the exercises
figures/          The figures, drawn in TikZ
build/            Build directory; created by make and not version controlled
```

The book reads nothing outside its own directory. The figures are drawn in TikZ in the same colours
and fonts as the page, and the code in the text is a typeset copy --- so a change to the course
material reaches the book only when the matching `.tex` file is changed.

---

## Adding a chapter
1. Create `chapters/NN/chapter.tex` with `\chapter{...}` and a `\label{ch:...}`.
2. Add `\input{chapters/NN/chapter}` to `book.tex`.
3. Put the exercises at the end of the chapter, with `\exercise{Title}{Kind}` and a
   `\label{ex:NN:M}`.
4. Put the answers in `back/answers/chapter.tex`, with `\solution{ex:NN:M}{Title}`.

Cross-references between chapters are written `\kapref{ch:...}`, never with a hard-coded chapter
number.

Make the same change in the Swedish edition, with the same labels. Every `\label` matches the
Swedish edition's, and so do the macro names: `\kapref` keeps its Swedish name here, where it reads
"chapter 3", so that a cross-reference added in one edition can be copied verbatim into the other.

---

## Licence
The book's text and figures, and the PDF built from them, are licensed under
[CC BY 4.0](../LICENSE) – Erik Pihl. That also applies to this directory's build files:
`canbook.sty`, `canbook.lua` and `Makefile`.
