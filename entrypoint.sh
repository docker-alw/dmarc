#!/bin/sh

IMAP_SERVER="${IMAP_SERVER}"
IMAP_USER="${IMAP_USER}"
IMAP_PASS="${IMAP_PASS}"
IMAP_MAILBOX="${IMAP_MAILBOX:-Inbox}"
OUTPUT_DIR="${OUTPUT_DIR:-/app}"
OUTPUT_FORMAT="${OUTPUT_FORMAT:-html_static}"
OUTPUT_ASSETS="${OUTPUT_ASSETS:-./assets}"
LOOKUP_ADDR="${LOOKUP_ADDR:-true}"
MERGE_REPORT="${MERGE_REPORT:-true}"

if [ -z "${IMAP_SERVER}" ]; then
    echo "IMAP_SERVER not set"
    exit 1
fi
if [ -z "${IMAP_USER}" ]; then
    echo "IMAP_USER not set"
    exit 1
fi
if [ -z "${IMAP_PASS}" ]; then
    echo "IMAP_PASS not set"
    exit 1
fi

envsubst < /config.dist.yaml > /config.yaml

/opt/dmarc-report-converter/dmarc-report-converter --version
/opt/dmarc-report-converter/dmarc-report-converter --config /config.yaml
