Bootstrap: docker
From: biocorecrg/debian-perlbrew-pyenv3-java:stretch

%runscript
    echo "Welcome to BiocoreCRG Interproscan Image"

%post
	
	IPSCAN_VERSION=5.32-71.0
	IPSCAN_DATA=/nfs/db/iprscan/data
	
	# Install InterPro
	
	cd /usr/local; curl --fail --silent --show-error --location --remote-name ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${IPSCAN_VERSION}/alt/interproscan-core-${IPSCAN_VERSION}.tar.gz && \
		curl --fail --silent --show-error --location --remote-name ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${IPSCAN_VERSION}/alt/interproscan-core-${IPSCAN_VERSION}.tar.gz.md5 && \
		md5sum -c interproscan-core-${IPSCAN_VERSION}.tar.gz.md5
	
	cd /usr/local; tar zxf interproscan-core-${IPSCAN_VERSION}.tar.gz && rm interproscan-core-${IPSCAN_VERSION}.tar.gz interproscan-core-${IPSCAN_VERSION}.tar.gz.md5
	
	PATH="/usr/local/interproscan-${IPSCAN_VERSION}:${PATH}"
	
	# Copy extra binaries. They might be downloaded from an URL in the future
	
	tar zxf /tmp/signalp-4.1b.Linux.tar.Z -C /usr/local/interproscan-${IPSCAN_VERSION}/bin/signalp/4.1 --strip-components 1
	
	tar zxf /tmp/tmhmm-2.0c.Linux.tar.gz -C /tmp && \
		 cp /tmp/tmhmm-2.0c/bin/decodeanhmm.Linux_x86_64 /usr/local/interproscan-${IPSCAN_VERSION}/bin/tmhmm/2.0c/decodeanhmm
	
	tar xzf /tmp/phobius101_linux.tar.gz -C /usr/local/interproscan-${IPSCAN_VERSION}/bin/phobius/1.01 --strip-components 3
	
	# Replace interproscan.properties
	
	ln -s /usr/local/interproscan-${IPSCAN_VERSION} /usr/local/interproscan
	cp /tmp/interproscan.properties /usr/local/interproscan
	
	# Hardcoded Data
	cd /usr/local/interproscan; rm -rf data; ln -s ${IPSCAN_DATA} data
	chmod -R a+rx /usr/local/interproscan/bin
	cd /usr/local/bin; ln -s /usr/local/interproscan/interproscan.sh


%files

	external/signalp-4.1b.Linux.tar.Z /tmp/
	external/tmhmm-2.0c.Linux.tar.gz /tmp/
	external/phobius101_linux.tar.gz /tmp/
	interproscan.properties /tmp/


%labels
    Maintainer Toni Hermoso Pulido
    Version 0.1.0
