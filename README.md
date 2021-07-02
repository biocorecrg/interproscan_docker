# interproscan_docker

Docker recipe for building Interproscan

* External programs must be obtained by academic permissions. 
    * [SignalP](http://www.cbs.dtu.dk/services/SignalP/) ```signalp-4.1b.Linux.tar.Z```
    * [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/) ```tmhmm-2.0c.Linux.tar.gz```
    * [Phobious](https://phobius.sbc.su.se/) ```phobius101_linux.tar.gz```
        * Regarding phobius: https://www.biostars.org/p/238642/
    * Some modifications are also needed in those programs in advance, e. g., replacing ```/usr/bin/perl``` for ```/usr/bin/env perl```
    
**IMPORTANT:** ```IPSCAN_DATA``` build argument in the recipes must be adapted to fit the configuration of your HPC storage setup. A user with suitable permissions may need to run it for first time to index ```IPSCAN_DATA``` dataset. Details here: https://interproscan-docs.readthedocs.io/en/5.48-83.0/HowToRun.html

Last software versions of Interproscan include the whole data by default. We remove it from this container and we place it independently in a separate location pointed above. Care must be taken to place data in the desired location.

Always Match program and data versions and ensure this is reflected in ```interproscan.properties``` file. Otherwise the program is not likely to work.

Building with Singularity:

    sudo singularity build iprscan-5.48-83.0.sif Singularity

