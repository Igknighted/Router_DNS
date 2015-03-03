#!/bin/bash

if ! grep -q -i "release 7" /etc/redhat-release; then
  echo "You are not running a RHEL 7 compatible OS."
  exit
fi

read -p "This has only been tested on RHEL 7 and CentOS 7, if you want to continue type in YES (all uppercased): " CONTINUE
if [ "$CONTINUE" != "YES" ]; then
	echo Not going to run setup since you did not type in YES.
	exit
fi


rpm -i http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install pdns-backend-geo pdns-backend-pipe vim php php-pecl-geoip bind-utils -y


wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
gunzip GeoLiteCity.dat.gz
mv GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat

echo > /etc/pdns/bindbackend.conf

sed -i '/^distributor-threads=3/d' /etc/pdns/pdns.conf
sed -i '/^pipebackend-abi-version=3/d' /etc/pdns/pdns.conf
sed -i '/^pipe-command=/d' /etc/pdns/pdns.conf
sed -i '/^launch=/d' /etc/pdns/pdns.conf
sed -i '/^bind-config=/d' /etc/pdns/pdns.conf


sed -i '/# launch=/a bind-config=/etc/pdns/bindbackend.conf' /etc/pdns/pdns.conf
sed -i '/# launch=/a distributor-threads=3' /etc/pdns/pdns.conf
sed -i '/# launch=/a pipebackend-abi-version=3' /etc/pdns/pdns.conf
sed -i '/# launch=/a pipe-command=/etc/pdns/dns-coprocessor.php' /etc/pdns/pdns.conf
sed -i '/# launch=/a launch=bind,pipe' /etc/pdns/pdns.conf


mkdir /etc/pdns/php-zones/

cd /etc/pdns/
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/scripts/dns-coprocessor.php
chmod +x dns-coprocessor.php

cd /etc/pdns/php-zones/
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/scripts/example.com.php
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/scripts/txt1.example.com.php

systemctl enable pdns
systemctl restart pdns
