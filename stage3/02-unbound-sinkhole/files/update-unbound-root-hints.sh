#!/bin/bash
set -euo pipefail

unbound-anchor
curl -sSf -o /var/lib/unbound/root.hints https://www.internic.net/domain/named.root
service unbound reload
