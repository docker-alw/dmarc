# dmarc

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/docker-alw/dmarc/main.svg)](https://results.pre-commit.ci/latest/github/docker-alw/dmarc/main)
[![dependabot update](https://github.com/docker-alw/dmarc/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/docker-alw/dmarc/actions/workflows/dependabot/dependabot-updates)
[![dependabot validate](https://github.com/docker-alw/dmarc/actions/workflows/dependabot_validate.yml/badge.svg)](https://github.com/docker-alw/dmarc/actions/workflows/dependabot_validate.yml)
[![Build Main Image](https://github.com/docker-alw/dmarc/actions/workflows/build_image.yml/badge.svg)](https://github.com/docker-alw/dmarc/actions/workflows/build_image.yml)

Generate static HTML overview for DMARC messages based on https://github.com/tierpod/dmarc-report-converter/.

## Run

To run this container use:
```
docker run -e IMAP_SERVER="mail.example.com" -e IMAP_USER="j.doe" -e IMAP_PASS="15zLuFR8ZJhEfwoPQYbTeGh1vWf0OgZr" -v "/path/to/dmarc-results/:/app/" "ghcr.io/docker-alw/dmarc"
```

After that you can access the results as static HTML in `/path/to/dmarc-results/`.

Here a list of all supported configuration variables that can be changed by setting environment variables via `-e`:

| ENV | Default | Description |
| --- | ------- | ----------- |
| `IMAP_SERVER` |  | DNS of IMAP server to grab DMARC e-mails from |
| `IMAP_PORT` | `993` | Port of IMAP server to grab DMARC e-mails from; port **must** use TLS and not StartTLS due to [implementation in code](https://github.com/tierpod/dmarc-report-converter/blob/master/cmd/dmarc-report-converter/imap.go#L19) |
| `IMAP_USER` |  | Username of IMAP account the contains DMARC e-mails |
| `IMAP_PASS` |  | Password of IMAP account the contains DMARC e-mails |
| `IMAP_MAILBOX` | Inbox | Mailbox where DMARC e-mails are stored |
| `OUTPUT_DIR` | `/app` | Directory where generated output should be stored within the container |
| `OUTPUT_TEMPLATE` | `{{ .ID }}` | template to use as filename for generated output |
| `OUTPUT_FORMAT` | `html_static` | Format used to generate output in (see [tierpod/dmarc-report-converter](https://github.com/tierpod/dmarc-report-converter/#configuration) for details) |
| `OUTPUT_ASSETS` | `./assets` | Directory containing all generated assets when format is `html` |
| `LOOKUP_ADDR` | `true` | Reverse lookup IP addresses in DMARC reports via DNS. Setting to `false` disables lookup |
| `MERGE_REPORT` | `true` | Merge DMARC reports into one output file instead of one file per report |
