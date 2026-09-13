# Both editions of the book.
#
#   make                 build both editions
#   make sv              build sv/can-sv.pdf only
#   make en              build en/can-en.pdf only
#   make VERSION=v2      any of the above, with the version on the title page
#   make clean           remove everything the two builds write
#
# Each edition has a Makefile of its own and is built the same way; this one only passes the work
# on, so that `make` at the root still builds the book the way it did when there was only one.
VERSION ?=

.PHONY: all sv en clean

all: sv en

sv en:
	$(MAKE) -C $@ VERSION=$(VERSION)

clean:
	$(MAKE) -C sv clean
	$(MAKE) -C en clean
