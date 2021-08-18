# vim:set ft=dockerfile:
FROM	alpine:latest as builder

ENV	GOPATH /go
WORKDIR /go
RUN	apk add --no-cache go make git
# Download requires GOPATH mode as .git is required by Makefile
ENV	GO111MODULE off
# always return true as the repository has no valid go-get structure
RUN	go get -v -d -u github.com/tierpod/dmarc-report-converter || true
# Makefile requires module-aware mode
ENV	GO111MODULE on
WORKDIR	/go/src/github.com/tierpod/dmarc-report-converter
RUN	make install

FROM	alpine:latest

WORKDIR	/opt

RUN	apk add --no-cache gettext \
		&& adduser \
			-u 1001 \
			-s /bin/sh \
			-D \
			dmarc

COPY	--from=builder --chown=dmarc:dmarc /opt/dmarc-report-converter /opt/dmarc-report-converter
COPY	./config.yaml /config.dist.yaml
COPY	./entrypoint.sh /entrypoint.sh

VOLUME	/app

USER	dmarc

WORKDIR	/opt/dmarc-report-converter

CMD 	["/bin/sh", "/entrypoint.sh"]
