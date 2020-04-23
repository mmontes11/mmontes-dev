#!/bin/sh

set -e

echo "⚙️   Configuring subdomains..."

echo "SUBDOMAIN_CONFS=$SUBDOMAIN_CONFS"

for s in $(echo $SUBDOMAIN_CONFS | sed "s/,/ /g"); do
    wget "https://raw.githubusercontent.com/mmontes11/mmontes-dev/master/config/$s.subdomain.conf"
done
