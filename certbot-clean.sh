#!/usr/bin/env bash
set -e
set -u
set -o pipefail

NSUPDATE="nsupdate -k /path/to/private"
DNSSERVER="masterns.yourdomain.tld"
ZONE="yourzonename.tld"
TTL=300

printf "server %s\nzone %s.\nupdate delete _acme-challenge.%s. %d in TXT \"%s\"\nsend\n" "${DNSSERVER}" "${ZONE}" "${CERTBOT_DOMAIN}" "${TTL}" "${CERTBOT_VALIDATION}" | $NSUPDATE
