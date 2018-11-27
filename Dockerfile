FROM biocorecrg/debian-perlbrew-pyenv3-java:stretch

# File Author / Maintainer
MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu> 

ARG IPSCAN_VERSION=5.32-71.0
ARG IPSCAN_DATA=/nfs/db/iprscan/5.32-71.0

# Install InterPro

RUN cd /usr/local; curl --fail --silent --show-error --location --remote-name ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${IPSCAN_VERSION}/alt/interproscan-core-${IPSCAN_VERSION}.tar.gz && \
	curl --fail --silent --show-error --location --remote-name ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${IPSCAN_VERSION}/alt/interproscan-core-${IPSCAN_VERSION}.tar.gz.md5 && \
	md5sum -c interproscan-core-${IPSCAN_VERSION}.tar.gz.md5

RUN cd /usr/local; tar zxf interproscan-core-${IPSCAN_VERSION}.tar.gz && rm interproscan-core-${IPSCAN_VERSION}.tar.gz interproscan-core-${IPSCAN_VERSION}.tar.gz.md5

ENV PATH "/usr/local/interproscan-${IPSCAN_VERSION}:${PATH}"

# Copy extra binaries. They might be downloaded from an URL in the future

COPY external/signalp-4.1b.Linux.tar.Z /tmp/
RUN tar zxf /tmp/signalp-4.1b.Linux.tar.Z -C /usr/local/interproscan-${IPSCAN_VERSION}/bin/signalp/4.1 --strip-components 1

COPY external/tmhmm-2.0c.Linux.tar.gz /tmp/
RUN  tar zxf /tmp/tmhmm-2.0c.Linux.tar.gz -C /tmp && \
     cp /tmp/tmhmm-2.0c/bin/decodeanhmm.Linux_x86_64 /usr/local/interproscan-${IPSCAN_VERSION}/bin/tmhmm/2.0c/decodeanhmm


COPY external/phobius101_linux.tar.gz /tmp/
RUN  tar xzf /tmp/phobius101_linux.tar.gz -C /usr/local/interproscan-${IPSCAN_VERSION}/bin/phobius/1.01 --strip-components 3

# Replace interproscan.properties

COPY interproscan.properties /usr/local/interproscan-${IPSCAN_VERSION}/interproscan.properties

RUN ln -s /usr/local/interproscan-${IPSCAN_VERSION} /usr/local/interproscan

# Hardcoded Data
VOLUME ${IPSCAN_DATA}
RUN cd /usr/local/interproscan; rm -rf data; ln -s ${IPSCAN_DATA} data

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*
