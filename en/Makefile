# Build the English edition: two LuaLaTeX passes, the second for the contents and the references.
#
#   make                 build can-en.pdf, dated today
#   make VERSION=v2      the same, with the version on the title page
#   make clean           remove everything the build writes
#
# The Swedish edition is in ../sv and builds the same way. The book reads nothing outside its own
# directory: the figures are drawn in TikZ in figures/, and the code in the text is a typeset copy
# of the course material's, so a change to a lecture reaches the book only when the matching .tex
# file is changed - in both editions.

ROOT    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
BUILD   := $(ROOT)/build
VERSION ?=
LATEX   := lualatex -interaction=nonstopmode -halt-on-error -file-line-error \
           -output-directory=$(BUILD)
BOOKTEX := $(LATEX) -jobname=book '\def\bookversion{$(VERSION)}\input{book.tex}'

SOURCES := book.tex canbook.sty canbook.lua \
           $(wildcard front/*.tex chapters/*/*.tex back/*/*.tex figures/*.tex)

.PHONY: all clean FORCE

all: can-en.pdf

# The version the last build was made for. The file is rewritten only when VERSION changes, so a
# new version - or none after one - rebuilds the title page and nothing else does.
$(BUILD)/version: FORCE
	@mkdir -p $(BUILD)
	@echo '$(VERSION)' | cmp -s - $@ || echo '$(VERSION)' > $@

can-en.pdf: $(SOURCES) $(BUILD)/version
	@mkdir -p $(BUILD)
	cd $(ROOT) && $(BOOKTEX) >/dev/null || (tail -40 $(BUILD)/book.log; exit 1)
	cd $(ROOT) && $(BOOKTEX) >/dev/null || (tail -40 $(BUILD)/book.log; exit 1)
	@! grep -q "There were undefined references" $(BUILD)/book.log || \
	    (echo "error: undefined references; see $(BUILD)/book.log"; exit 1)
	cp $(BUILD)/book.pdf $@

clean:
	rm -rf $(BUILD) can-en.pdf
