# Graphprot docker file

This repository contains scripts to construct a docker image for [GraphProt](http://www.bioinf.uni-freiburg.de/Software/GraphProt/).


## Running GraphProt

This docker image is available on [dockerhub](https://hub.docker.com/r/croth/graphprot/). `docker pull croth1/graphprot` downloads the latest version.

Data from a directory on the host can be mounted using `-v <host_path>:/data`. The docker image uses `/data` as working directory.

Following syntax will run GraphProt:

~~~
docker run -v <host_path>:/data croth/graphprot <graphprot_options>
~~~

### Example

Host file system:

~~~
/path/to/host/data
├── negset.fa
└── posset.fa
~~~

Training a GraphProt model:

~~~
docker run -v /path/to/host/data:/data croth/graphprot --action train -fasta posset.fa -negset negset.fa
~~~

## Building the docker image

Building the docker image requires [docker](https://www.docker.com/).

~~~
git clone https://github.com/croth1/graphprot-docker.git
cd graphprot-docker
make
~~~
