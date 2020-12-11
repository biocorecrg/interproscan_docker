# interproscan_docker
Docker recipe for building Interproscan

* External programs must be obtained by academic permissions. Some modifications are also needed, e. g., replacing ```/usr/bin/perl``` for ```/usr/bin/env perl```
* Regarding phobius: https://www.biostars.org/p/238642/

Building Singularity:

    sudo singularity build iprscan-5.48-83.0.sif Singularity

