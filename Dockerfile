# vim:set ft=dockerfile:
# hadolint ignore=DL3007
FROM	alpine:latest AS builder

# hadolint ignore=DL3018
RUN	apk add --no-cache go make git
# hadolint ignore=DL3059
RUN	git clone https://github.com/tierpod/dmarc-report-converter.git /tmp/dmarc-report-converter
WORKDIR	/tmp/dmarc-report-converter
RUN	make install

# hadolint ignore=DL3007
FROM	alpine:latest

COPY test.sh /test.sh
RUN adduser \
			-u 1001 \
			-s /bin/sh \
			-D \
			dmarc
COPY	./config.dist.yaml ./entrypoint.sh /
# hadolint ignore=DL3018
RUN	apk --no-cache add gettext
VOLUME	/app
RUN	apk --no-cache upgrade
COPY	--from=builder --chown=dmarc:dmarc /opt/dmarc-report-converter /opt/dmarc-report-converter
USER	dmarc
WORKDIR	/opt/dmarc-report-converter
ENTRYPOINT 	["/bin/sh", "/entrypoint.sh"]
