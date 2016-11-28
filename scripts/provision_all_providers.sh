#!/usr/bin/env bash
# provision script that is run on all providers

# This is run before any provider-specific provisioners, despite being later in
# the Vagrantfile (see https://github.com/mitchellh/vagrant/issues/5641#issuecomment-107104658)

# Exit immediately if some command fails
set -e

# replace baked-in apt repo with more local one
sed -i -E 's#https?:\/{2}[^ \t]+#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list

apt-get -y update
apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
# ^ don't prompt to replace configuration files

# install proxy cli from uploaded guest files
INSTALL_DIR="/usr/local/bin"
cd /home/vagrant/guestfiles/proxy_cli
cp -rf proxy $INSTALL_DIR
cp -rf proxy_modules $INSTALL_DIR
cd $INSTALL_DIR
chown -R root:root proxy
chown -R root:root proxy_modules
chmod 775 -R proxy_modules
chmod 2775 proxy
ls $INSTALL_DIR/proxy_modules/*/setup | bash
# ^ run module setup scripts