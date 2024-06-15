#!/bin/ash
# shellcheck shell=dash

set -x -e -o pipefail

getent passwd | grep 'dmarc' | grep 1001
test -e /opt/dmarc-report-converter/dmarc-report-converter
test -e /config.dist.yaml
/opt/dmarc-report-converter/dmarc-report-converter --version
