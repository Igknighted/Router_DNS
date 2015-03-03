#!/bin/bash
if [ -f /etc/debian_version ] && grep -q -i ubuntu /etc/issue; then
	echo Running ubuntu install script.
	wget -qO- https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup_ubuntu.sh | bash
elif [ -f /etc/redhat-release ]; then
	echo Running RHEL install script.
	wget -qO- https://raw.githubusercontent.com/Igknighted/Router_DNS/master/setup_rhel.sh | bash
fi
