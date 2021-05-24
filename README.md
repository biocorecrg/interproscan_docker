# interproscan_docker

Docker recipe for building Interproscan

* External programs must be obtained by academic permissions. 
    * [SignalP](http://www.cbs.dtu.dk/services/SignalP/)
    * [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/)
    * [Phobious](https://phobius.sbc.su.se/)
        * Regarding phobius: https://www.biostars.org/p/238642/
    * Some modifications are also needed in those programs in advance, e. g., replacing ```/usr/bin/perl``` for ```/usr/bin/env perl```
    
IMPORTANT: **IPSCAN_DATA** build argument in the recipes must be adapted to fit the configuration of your HPC storage setup.

Last software versions of Interproscan include the whole data by default. We remove it from this container and we place it independentlyt in a separate location pointed above. Care must be taken to place data in the desired location.

Always Match program and data versions and ensure this is reflected in ```interproscan.properties``` file. Otherwise the program is not likely to work.

Building with Singularity:

    sudo singularity build iprscan-5.48-83.0.sif Singularity

