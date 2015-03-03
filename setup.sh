#!/bin/bash
if [ -f /etc/debian_version ] && grep -q -i ubuntu /etc/issue; then
	echo Running ubuntu install script.
	wget https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup_ubuntu.sh && bash setup_ubuntu.sh
elif [ -f /etc/redhat-release ]; then
	echo Running RHEL install script.
	wget -https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup_rhel.sh && bash setup_rhel.sh
fi
