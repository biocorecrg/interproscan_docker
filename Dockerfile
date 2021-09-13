FROM biocorecrg/debian-perlbrew-pyenv3-java:buster AS builder

ARG IPSCAN_VERSION=5.48-83.0

# Install InterPro

RUN cd /usr/local; curl --retry 3 --fail --silent --show-error --location --remote-name https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${IPSCAN_VERSION}/interproscan-${IPSCAN_VERSION}-64-bit.tar.gz && \
	curl --retry 3 --fail --silent --show-error --location --remote-name https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${IPSCAN_VERSION}/interproscan-${IPSCAN_VERSION}-64-bit.tar.gz.md5 && \
	md5sum -c interproscan-${IPSCAN_VERSION}-64-bit.tar.gz.md5

RUN cd /usr/local; tar zxf interproscan-${IPSCAN_VERSION}-64-bit.tar.gz --exclude "interproscan-${IPSCAN_VERSION}/data" && rm interproscan-${IPSCAN_VERSION}-64-bit.tar.gz interproscan-${IPSCAN_VERSION}-64-bit.tar.gz.md5

# Replace interproscan.properties
COPY interproscan.open.properties /usr/local/interproscan-${IPSCAN_VERSION}/interproscan.properties
RUN chmod a+r /usr/local/interproscan-${IPSCAN_VERSION}/interproscan.properties

# Copy external software
COPY external/signalp-4.1b.Linux.tar.Z /tmp/
RUN tar zxf /tmp/signalp-4.1b.Linux.tar.Z -C /usr/local/interproscan-${IPSCAN_VERSION}/bin/signalp/4.1 --strip-components 1

COPY external/tmhmm-2.0c.Linux.tar.gz /tmp/
RUN  tar zxf /tmp/tmhmm-2.0c.Linux.tar.gz -C /tmp && \
     cp /tmp/tmhmm-2.0c/bin/decodeanhmm.Linux_x86_64 /usr/local/interproscan-${IPSCAN_VERSION}/bin/tmhmm/2.0c/decodeanhmm


COPY external/phobius101_linux.tar.gz /tmp/
RUN  tar xzf /tmp/phobius101_linux.tar.gz -C /usr/local/interproscan-${IPSCAN_VERSION}/bin/phobius/1.01 --strip-components 3

RUN cd /usr/local/interproscan-${IPSCAN_VERSION}; rm -rf data

FROM biocorecrg/debian-perlbrew-pyenv3-java:buster

# File Author / Maintainer
MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

ARG IPSCAN_VERSION=5.48-83.0

ENV PATH "/usr/local/interproscan:${PATH}"

COPY --from=builder /usr/local/interproscan-${IPSCAN_VERSION} /usr/local/interproscan

WORKDIR /usr/local/interproscan

# Extra packages
RUN apt-get update; apt-get install -y libdw1

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*
