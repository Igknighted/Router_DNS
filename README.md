# Router_DNS
DNS Routing With PowerDNS (The Poor Man's CDN Solution)

Router_DNS is a solution that makes it possible for you to program how your DNS is handled via PHP scripting. It stages your environment to be ready to dictate DNS based on geographical location. It can be used as a ghetto load balancer, but it's best used for content distribution.

#### Use Case Scenario
The main use case scenario for this would be a CDN. If your target Audiences are throughout the US and Austrailia, you would setup servers on the east and west coast of the US and a server in Austrailia. With Router_DNS, you can ensure that Austrailian traffic goes to the server down under and you can split traffic between the US.

You can also use the longitude and latitude information to figure out which datacenter is closest for your end user and send them on their way according to that.  

#### Requirements
This script was specifically written on/for Ubuntu 14.04LTS and CentOS/RHEL 7. However you might be able to get away with using it on 12.04LTS and newer versions of Ubuntu and it definitely will not work on older versions of CentOS/RHEL. However... I promise NOTHING.

#### Quick Setup
Just run this command on your server. It will detect if you're running Ubuntu or CentOS and run the appropriate install script.
```
wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup.sh && bash setup.sh
```

There is an example configuration for example.com in these files:
```
/etc/powerdns/php-zones/example.com.php
/etc/powerdns/php-zones/txt1.example.com.php
```

Hostnames are housed in their own files in `/etc/powerdns/php-zones/`. The file `example.com.php` holds the records for any queries against `example.com`. The file `txt1.example.com.php` holds records for `txt1.example.com`.

Note: After the install, you may want to delete the setup scripts. You can just lazily run `rm -rf setup.sh setup_rhel.sh setup_ubuntu.sh`
