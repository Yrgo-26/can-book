# Bygg den svenska upplagan: två LuaLaTeX-pass, det andra för innehållsförteckning och referenser.
#
#   make                 bygg can-sv.pdf, daterad idag
#   make VERSION=v2      detsamma, med versionen på titelsidan
#   make clean           ta bort allt bygget skriver
#
# Den engelska upplagan ligger i ../en och byggs på samma sätt. Boken läser ingenting utanför sin
# egen katalog: figurerna ritas i TikZ i figures/, och koden i texten är en satt kopia av
# kursmaterialets, så en ändring i en föreläsning når boken först när motsvarande .tex-fil ändras.

ROOT    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
BUILD   := $(ROOT)/build
VERSION ?=
LATEX   := lualatex -interaction=nonstopmode -halt-on-error -file-line-error \
           -output-directory=$(BUILD)
BOOKTEX := $(LATEX) -jobname=book '\def\bookversion{$(VERSION)}\input{book.tex}'

SOURCES := book.tex canbook.sty canbook.lua \
           $(wildcard front/*.tex chapters/*/*.tex back/*/*.tex figures/*.tex)

.PHONY: all clean FORCE

all: can-sv.pdf

# Versionen bygget senast gjordes för. Filen skrivs om bara när VERSION ändras, så att en ny
# version - eller ingen efter en - bygger om titelsidan och ingenting annat gör det.
$(BUILD)/version: FORCE
	@mkdir -p $(BUILD)
	@echo '$(VERSION)' | cmp -s - $@ || echo '$(VERSION)' > $@

can-sv.pdf: $(SOURCES) $(BUILD)/version
	@mkdir -p $(BUILD)
	cd $(ROOT) && $(BOOKTEX) >/dev/null || (tail -40 $(BUILD)/book.log; exit 1)
	cd $(ROOT) && $(BOOKTEX) >/dev/null || (tail -40 $(BUILD)/book.log; exit 1)
	@! grep -q "There were undefined references" $(BUILD)/book.log || \
	    (echo "error: odefinierade referenser; se $(BUILD)/book.log"; exit 1)
	cp $(BUILD)/book.pdf $@

clean:
	rm -rf $(BUILD) can-sv.pdf
