#!/usr/bin/env bash
# provision script that is run on all providers
# this is run after any provider-specific scripts/options

apt-get -y update

# install proxy cli  from uploaded guest files
cd /home/vagrant/guestfiles/proxy_cli
cp -rf proxy /usr/local/bin
cp -rf proxy_modules /usr/local/bin
cd /usr/local/bin
chown root:root proxy*
chmod 775 -R proxy_modules
chmod 7775 proxy