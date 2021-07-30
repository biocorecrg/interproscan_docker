# interproscan_docker

[![DOI](https://zenodo.org/badge/150708687.svg)](https://zenodo.org/badge/latestdoi/150708687)

Container recipes for building [Interproscan](https://interproscan-docs.readthedocs.io). Both [Docker](https://www.docker.com/) and [Singularity](https://singularity.hpcng.org/) versions are provided (the latter recomended).

* If you want to use Interproscan external privative software, these programs must be obtained first with granted academic permissions.
    * [SignalP](http://www.cbs.dtu.dk/services/SignalP/) ```signalp-4.1b.Linux.tar.Z```
    * [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/) ```tmhmm-2.0c.Linux.tar.gz```
    * [Phobious](https://phobius.sbc.su.se/) ```phobius101_linux.tar.gz```
        * Regarding phobius: https://www.biostars.org/p/238642/
    * Keep in mind that some other modifications are also needed in those programs above in advance, e. g., replacing ```/usr/bin/perl``` for ```/usr/bin/env perl```

Last software package versions of Interproscan include the whole data by default. For container performance and distribution, we don't keep Interproscan data directory in the container and we replace it for a symbolic link / volume pointing to a defined location in our HPC storage by using build argument ```IPSCAN_DATA```.

It is important to ensure that program and data versions match and that this is adequately reflected in ```interproscan.properties``` or ```interproscan.open.properties``` files. Otherwise Interproscan is not likely to work.

## Building from Docker recipes

    # With privative software
    docker build --build-arg IPSCAN_DATA=/path/to/5.48-83.0 -t iprscan:5.48-83.0 -f Dockerfile .
    sudo singularity build iprscan-5.48-83.0.sif docker-daemon://iprscan:5.48-83.0
    # Without privative software
    docker build --build-arg IPSCAN_DATA=/path/to/5.48-83.0 -t iprscan-open:5.48-83.0 -f Dockerfile.open .
    sudo singularity build iprscan-5.48-83.0.open.sif docker-daemon://iprscan-open:5.48-83.0

## Building from Singularity recipes

**As commented above, you need to adapt Singularity recipes first and change ```IPSCAN_DATA``` to fit your system.**

    # With privative software
    sudo singularity build iprscan-5.48-83.0.sif Singularity
    # Without privative software
    sudo singularity build iprscan-5.48-83.0.open.sif Singularity.open

You can avoid using ```sudo``` with ```--fakeroot``` Singularity build option.

* [Pregenerated open images](https://biocore.crg.eu/iprscan/)

## NOTES

* ```IPSCAN_DATA``` build argument in the recipes must be adapted to fit the configuration of your HPC storage setup. Moreover, keep into account that a user with suitable permissions may need to run it for first time to index ```IPSCAN_DATA``` dataset (e.g., with ```python3 /usr/local/interproscan/initial_setup.py```). You can use the very container images. Details here: https://interproscan-docs.readthedocs.io/en/5.48-83.0/HowToRun.html
* Depending on your setup, you may need to change ```SINGULARITY_TMPDIR``` (and ```SINGULARITY_CACHEDIR```) environment variables for pointing to a location with enough space. More details at: https://singularity.hpcng.org/admin-docs/master/installation.html
* When using Singularity ensure ```IPSCAN_DATA``` is in a ```bind path``` directory. More details at: https://singularity.hpcng.org/admin-docs/master/configfiles.html
