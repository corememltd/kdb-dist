FROM debian:9

ARG VCS_REF=dev
ARG BUILD_DATE=dev

ARG L64_URL=https://cl.ly/2r1v1v3h0l41/download/l64.zip
ARG L64_SHA256=28c26f796a7fa9267a3061598fe0e1e34208b4deb5932db42adc78f9d2a74481

LABEL	org.label-schema.schema-version="1.0" \
	org.label-schema.name=kdb \
	org.label-schema.description="kdb+ Docker Distribution" \
	org.label-schema.vendor="Kx" \
	org.label-schema.license="Apache-2.0" \
	org.label-schema.url="https://code.kx.com" \
	org.label-schema.version="${VERSION:-dev}" \
	org.label-schema.vcs-url="https://github.com/KxSystems/kdb-dist.git" \
	org.label-schema.vcs-ref="$VCS_REF" \
	org.label-schema.build-date="$BUILD_DATE" \
	org.label-schema.docker.cmd="docker run kxsys/kdb"

SHELL ["/bin/sh", "-x", "-c"]

RUN passwd -d root

RUN apt-get update \
	&& apt-get -yy --option=Dpkg::options::=--force-unsafe-io upgrade \
	&& apt-get -yy --option=Dpkg::options::=--force-unsafe-io install --no-install-recommends \
		ca-certificates \
		curl \
		python-minimal \
		python-urllib3 \
		rlwrap \
		runit \
		unzip \
	&& apt-get clean \
	&& find /var/lib/apt/lists -type f -delete

ENV QHOME=/opt/kx/kdb

RUN mkdir -p $QHOME
RUN curl -f -o /tmp/l64.zip -L $L64_URL \
	&& [ "$L64_SHA256" = "$(sha256sum /tmp/l64.zip | cut -b1-64)" ] \
	&& unzip -d $QHOME /tmp/l64.zip \
	&& rm /tmp/l64.zip
COPY docker/q.wrapper /usr/local/bin/q
COPY docker/kc.lic.py /opt/kx/

COPY docker/init /init

ENTRYPOINT ["/init"]
CMD ["q"]
