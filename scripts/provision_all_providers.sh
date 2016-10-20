#!/usr/bin/env bash
# provision script that is run on all providers
# this is run after any provider-specific scripts/options

# Exit immediately if some command fails
set -e

# replace baked-in mirror with local one
sed -i -E 's#https?:\/{2}[^ \t]+#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list

apt-get -y update
apt-get -y upgrade

# install proxy cli from uploaded guest files
cd /home/vagrant/guestfiles/proxy_cli
cp -rf proxy /usr/local/bin
cp -rf proxy_modules /usr/local/bin
cd /usr/local/bin
chown -R root:root proxy*
chmod 775 -R proxy_modules
chmod 2775 proxy
