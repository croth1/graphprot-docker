FROM ubuntu:14.04

RUN apt-key adv\
	--keyserver hkp://ha.pool.sks-keyservers.net:80\
	--recv-keys 51716619E084DAB9\
	&& echo 'deb [arch=amd64,i386] http://cran.rstudio.com/bin/linux/ubuntu trusty/' \
	>> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y\
	build-essential\
	gcc\
	perl\
	r-base-dev\
	libsvm3

RUN apt-get install -y\
	python2.7-minimal\
	python2.7-numpy\
	python-pip\
	ghostscript\
	pdf2svg

RUN echo 'install.packages(c("plyr"), repos="http://cran.us.r-project.org")' > /tmp/packages.R \
	&& Rscript /tmp/packages.R

COPY data/* /tmp/
WORKDIR /tmp

RUN tar xzf perf.src.tar.gz\
	&& rm -rf perf.src/perf\
	&& make -C perf.src\
	&& cp perf.src/perf /usr/bin\
	&& rm -rf perf.src.tar.gz perf.src

RUN tar xzf RNAshapes-2.1.6.tar.gz\
	&& cd RNAshapes-2.1.6 && ./configure --prefix=/usr\
	&& make\
	&& make install\
	&& cd .. && rm -rf RNAshapes-2.1.6.tar.gz RNAshapes-2.1.6

RUN tar xzf weblogo-3.2.1.tar.gz\
	&& cd weblogo-3.2.1\
	&& patch -p1 < ../weblogo-gs910.patch\
	&& sed -i 's/release_date =.*/release_date = "2012.01.31"/' weblogolib/__init__.py\
	&& sed -i 's/release_build =.*/release_build = "3.2.1"/' weblogolib/__init__.py\
	&& pip install /tmp/weblogo-3.2.1\
	&& cd .. && rm -rf weblogo-3.2.1.tar.gz weblogo-3.2.1 weblogo-gs910.patch

RUN tar xjf GraphProt-1.1.3.tar.bz2\
	&& sed -i 's/-static//g' GraphProt-1.1.3/EDeN/Makefile\
	&& make -C GraphProt-1.1.3/EDeN

RUN mkdir -p /data

WORKDIR /data
ENTRYPOINT [ "perl", "/tmp/GraphProt-1.1.3/GraphProt.pl"]
