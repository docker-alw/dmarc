# dmarc

Generate static HTML overview for DMARC messages based on https://github.com/tierpod/dmarc-report-converter/.

[![pipeline status](https://gitlab.com/docker-alw/dmarc/badges/main/pipeline.svg)](https://gitlab.com/docker-alw/dmarc/-/commits/main)

## Run

To run this container use:
```
docker run -e IMAP_SERVER="mail.example.com" -e IMAP_USER="j.doe" -e IMAP_PASS="15zLuFR8ZJhEfwoPQYbTeGh1vWf0OgZr" -v "/path/to/dmarc-results/:/app/" "registry.gitlab.com/docker-alw/dmarc"
```

After that you can access the results as static HTML in `/path/to/dmarc-results/`.

Here a list of all supported configuration variables that can be changed by setting environment variables via `-e`:

| ENV | Default | Description |
| --- | ------- | ----------- |
| `IMAP_SERVER` |  | DNS of IMAP server to grab DMARC e-mails from |
| `IMAP_PORT` | `143` | Port of IMAP server to grab DMARC e-mails from |
| `IMAP_USER` |  | Username of IMAP account the contains DMARC e-mails |
| `IMAP_PASS` |  | Password of IMAP account the contains DMARC e-mails |
| `IMAP_MAILBOX` | Inbox | Mailbox where DMARC e-mails are stored |
| `OUTPUT_DIR` | `/app` | Directory where generated output should be stored within the container |
| `OUTPUT_FORMAT` | `html_static` | Format used to generate output in (see [tierpod/dmarc-report-converter](https://github.com/tierpod/dmarc-report-converter/#configuration) for details) |
| `OUTPUT_ASSETS` | `./assets` | Directory containing all generated assets when format is `html` |
| `LOOKUP_ADDR` | `true` | Reverse lookup IP addresses in DMARC reports via DNS. Setting to `false` disables lookup |
| `MERGE_REPORT` | `true` | Merge DMARC reports into one output file instead of one file per report |
