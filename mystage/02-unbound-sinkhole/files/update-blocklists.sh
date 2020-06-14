#!/bin/bash
set -euo pipefail

/opt/blocklists/safelist.sh > /etc/unbound/lists.d/01-safelist.conf
/opt/blocklists/blocklist.sh > /etc/unbound/lists.d/02-blocklist.conf
service unbound reload
