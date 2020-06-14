#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Download all ticked blocklists from The Firebog's "The Big Blocklist
# Collection" [0] and block access to them with Unbound by redirecting traffic
# to 0.0.0.0.
#
#   [0]: https://firebog.net
(
  # Suspicious Lists
  curl -sSf "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts_without_controversies.txt" ;
  curl -sSf "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts" ;
  curl -sSf "https://v.firebog.net/hosts/static/w3kbl.txt" ;

  # Advertising Lists
  curl -sSf "https://adaway.org/hosts.txt" ;
  curl -sSf "https://v.firebog.net/hosts/AdguardDNS.txt" ;
  curl -sSf "https://v.firebog.net/hosts/Admiral.txt" ;
  curl -sSf "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt" ;
  curl -sSf "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt" ;
  curl -sSf "https://v.firebog.net/hosts/Easylist.txt" ;
  curl -sSf "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" ;
  curl -sSf "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts" ;
  curl -sSf "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts" ;

  # Tracking & Telemetry Lists
  curl -sSf "https://v.firebog.net/hosts/Easyprivacy.txt" ;
  curl -sSf "https://v.firebog.net/hosts/Prigent-Ads.txt" ;
  curl -sSf "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt" ;
  curl -sSf "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts" ;
  curl -sSf "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt" ;
  curl -sSf "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt" ;

  # Malicious Lists
  curl -sSf "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt" ;
  curl -sSf "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt" ;
  curl -sSf "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt" ;
  curl -sSf "https://mirror1.malwaredomains.com/files/justdomains" ;
  curl -sSf "https://v.firebog.net/hosts/Prigent-Crypto.txt" ;
  curl -sSf "https://v.firebog.net/hosts/Prigent-Malware.txt" ;
  curl -sSf "https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt" ;
  curl -sSf "https://www.malwaredomainlist.com/hostslist/hosts.txt" ;
  curl -sSf "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt" ;
  curl -sSf "https://phishing.army/download/phishing_army_blocklist_extended.txt" ;
  curl -sSf "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt" ;
  curl -sSf "https://v.firebog.net/hosts/Shalla-mal.txt" ;
  curl -sSf "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt" ;
  curl -sSf "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts" ;
  curl -sSf "https://urlhaus.abuse.ch/downloads/hostfile/" ;

  # Other Lists
  curl -sSf "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser" ;
) |
  cat |                # Combine all lists into one
  grep '^0\.0\.0\.0' | # Filter out any comments, etc. that aren't rules
  tr -d '\r' |         # Normalize line endings by removing Windows carriage returns
  sort -u |            # Remove any duplicates
  awk '{print "local-zone: \""$2".\" redirect\nlocal-data: \""$2". IN A 0.0.0.0\"\nlocal-data: \""$2". IN AAAA ::\""}' # Convert to Unbound configuration

