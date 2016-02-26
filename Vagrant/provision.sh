#!/bin/sh
# Vagrant box provisioning for PReVo build
#
# Actually it will also rebuild the dictionnary and put it in the right place.

sudo apt-get update
sudo apt-get install -y git autoconf libtool autopoint gettext libglib2.0-dev libexpat1-dev
if [ ! -d /vagrant/prevodb ]; then
	cd /vagrant
	git clone https://github.com/bpeel/prevodb.git
	patch -p1 < /vagrant/Vagrant/prevodb.patch
fi
cd /vagrant/prevodb
./autogen.sh --sysconfdir=/etc
make
make install

if [ ! -d /vagrant/revo ]; then
	cd /vagrant
	git clone https://github.com/bpeel/revo
fi

/usr/local/bin/prevodb -i /vagrant/revo -o /vagrant/
