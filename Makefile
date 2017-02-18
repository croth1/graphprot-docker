.PHONY: all

all:
	docker build -t croth/graphprot -t croth/graphprot:1.1.4 .
