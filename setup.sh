#!/bin/bash
if [ -f /etc/debian_version ] && grep -q -i ubuntu /etc/issue; then
	echo Running ubuntu install script.
	wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup_ubuntu.sh && echo setup_ubuntu.shccccccc
elif [ -f /etc/redhat-release ]; then
	echo Running RHEL install script.
	wget -https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup_rhel.sh && source setup_rhel.sh
fi
