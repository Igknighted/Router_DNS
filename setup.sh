#!/bin/bash

`cat /etc/issue | grep Ubuntu | awk '{print "export OS="$1" export VERSION="$2}'`

if [ "Ubuntu" != "$OS" ]; then
	echo This script was only designed to run on Ubuntu.
	exit
fi

read -p "This has only been tested on 14.04, if you want to continue type in YES (all uppercased): " CONTINUE
if [ "$CONTINUE" != "YES" ]; then
	echo Not going to run setup since you did not type in YES.
	exit
fi

apt-get update
apt-get --assume-yes install pdns-backend-geo pdns-backend-pipe vim php5 php5-dev php-pear libgeoip-dev
pecl install geoip

echo "extension=geoip.so" > /etc/php5/cli/conf.d/10-geoip.ini


wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
gunzip GeoLiteCity.dat.gz
mv GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat


echo "bind-config=/etc/powerdns/bindbackend.conf" > /etc/powerdns/pdns.d/pdns.simplebind.conf


sed -i '/^distributor-threads=3/d' /etc/powerdns/pdns.conf
sed -i '/^pipebackend-abi-version=3/d' /etc/powerdns/pdns.conf
sed -i '/^pipe-command=/d' /etc/powerdns/pdns.conf
sed -i '/launch=bind,pipe/d' /etc/powerdns/pdns.conf


sed -i '/# launch=/a distributor-threads=3' /etc/powerdns/pdns.conf
sed -i '/# launch=/a pipebackend-abi-version=3' /etc/powerdns/pdns.conf
sed -i '/# launch=/a pipe-command=/etc/powerdns/dns-coprocessor.php' /etc/powerdns/pdns.conf
sed -i '/# launch=/a launch=bind,pipe' /etc/powerdns/pdns.conf


mkdir /etc/powerdns/php-zones/

cd /etc/powerdns/
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/scripts/dns-coprocessor.php
chmod +x dns-coprocessor.php

cd /etc/powerdns/php-zones/
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/scripts/example.com.php
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/scripts/txt1.example.com.php

service pdns restart
