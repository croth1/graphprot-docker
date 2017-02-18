.PHONY: download clean all

all: download docker

docker:
	docker build -t croth/graphprot -t croth/graphprot:1.1.3 .

download:
	wget -P data http://osmot.cs.cornell.edu/kddcup/perf/perf.src.tar.gz
	wget -P data http://www.bioinf.uni-freiburg.de/Software/GraphProt/GraphProt-1.1.3.tar.bz2
	wget https://github.com/ostrokach/weblogo/archive/3.2.1.tar.gz -O data/weblogo-3.2.1.tar.gz
	wget -P data https://bibiserv.cebitec.uni-bielefeld.de/spool/download/bibiserv_1484743253_18653/RNAshapes-2.1.6.tar.gz

clean:
	rm -rf data/*.tar.gz*
	rm -rf data/*.tar.bz2*
