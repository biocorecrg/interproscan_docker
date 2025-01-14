# interproscan_docker

[![DOI](https://zenodo.org/badge/150708687.svg)](https://zenodo.org/badge/latestdoi/150708687)

Container recipes for building [Interproscan](https://interproscan-docs.readthedocs.io) (for [Docker](https://www.docker.com/) and [Singularity](https://singularity.hpcng.org/)).

- If you want to use Interproscan external privative software, these programs must be obtained first with granted academic permissions.
  - [SignalP](http://www.cbs.dtu.dk/services/SignalP/) `signalp-4.1b.Linux.tar.Z`
  - [TMHMM](http://www.cbs.dtu.dk/services/TMHMM/) `tmhmm-2.0c.Linux.tar.gz`
  - [Phobious](https://phobius.sbc.su.se/) `phobius101_linux.tar.gz`
    - Regarding phobius: https://www.biostars.org/p/238642/
  - Keep in mind that some other modifications are also needed in those programs above in advance, e. g., replacing `/usr/bin/perl` for `/usr/bin/env perl`

Last software package versions of Interproscan include the whole data by default. For container performance and distribution, we don't keep Interproscan data directory.

## Pregenerated images

- [Singularity](https://biocore.crg.eu/iprscan/)
- [Docker](https://hub.docker.com/r/biocorecrg/interproscan)

## Building from Docker recipes

    # With privative software
    docker build -t iprscan:5.72-103.0 -f Dockerfile .
    sudo singularity build iprscan-5.72-103.0.sif docker-daemon://iprscan:5.72-103.0
    # Without privative software
    docker build -t iprscan-open:5.72-103.0 -f Dockerfile.open .
    sudo singularity build iprscan-5.72-103.0.open.sif docker-daemon://iprscan-open:5.72-103.0

You can avoid using `sudo` with `--fakeroot` Singularity build option.

## Running

For running the container images, it is mandatory to mount a data directory that fits the same Interproscan version. Below some example commands:

```
# Docker
docker run --volume /path/to/data:/usr/local/interproscan/data --volume /path/to/scratch:/scratch -t biocorecrg/interproscan:5.72-103.0 /usr/local/interproscan/interproscan.sh -i /scratch/test.fa --goterms --iprlookup --pathways -o /scratch/out_interpro -f TSV

# Singularity
singularity exec -B /path/to/data:/usr/local/interproscan/data -e iprscan-5.72-103.0.open.sif /usr/local/interproscan/interproscan.sh -i /path/to/test2.fa --goterms --iprlookup --pathways -o /path/to/out_interpro -f TSV
```

## NOTES

- Moreover, keep into account that a user with suitable permissions may need first to index `/usr/local/interproscan/data` directory (e.g., with `python3 /usr/local/interproscan/initial_setup.py`). You can use the very container images. Details here: https://interproscan-docs.readthedocs.io/en/latest/HowToRun.html
- Depending on your setup, you may need to change `SINGULARITY_TMPDIR` (and `SINGULARITY_CACHEDIR`) environment variables for pointing to a location with enough space. More details at: https://singularity.hpcng.org/admin-docs/master/installation.html
