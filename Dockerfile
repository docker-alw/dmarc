# vim:set ft=dockerfile:
# hadolint ignore=DL3007
FROM	alpine:latest as builder

ENV	GOPATH /go
WORKDIR /go
# hadolint ignore=DL3018
RUN	apk add --no-cache go make git
# Download requires GOPATH mode as .git is required by Makefile
ENV	GO111MODULE off
# always return true as the repository has no valid go-get structure
RUN	go get -v -d -u github.com/tierpod/dmarc-report-converter || true
# Makefile requires module-aware mode
ENV	GO111MODULE on
WORKDIR	/go/src/github.com/tierpod/dmarc-report-converter
RUN	make install

# hadolint ignore=DL3007
FROM	alpine:latest

RUN adduser \
			-u 1001 \
			-s /bin/sh \
			-D \
			dmarc
COPY	./config.dist.yaml ./entrypoint.sh /
# hadolint ignore=DL3018
RUN	apk --no-cache add gettext
COPY	--from=builder --chown=dmarc:dmarc /opt/dmarc-report-converter /opt/dmarc-report-converter
RUN	apk --no-cache upgrade
VOLUME	/app
USER	dmarc
WORKDIR	/opt/dmarc-report-converter
ENTRYPOINT 	["/bin/sh", "/entrypoint.sh"]
