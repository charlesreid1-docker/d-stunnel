#!/bin/bash
#
# Run this on the server - 
# either the server that runs stunnel,
# or the server that runs the docker stunnel container.

function usage {
	echo ""
	echo "open_fw.sh script:"
	echo "opens the firewall to a particular port using iptables."
	echo "specify a port number for the firewall to open:"
	echo ""
	echo "        ./open_fw.sh 666"
	echo ""
}


if [[ "$#" -ne 1 || $1 =~ "[0-9]\{1,5\}" ]];
then
	usage
else

	iptables -A INPUT -p tcp --dport ${1} -j ACCEPT
	iptables -A FORWARD -p tcp -j ACCEPT --dport ${1} -m state --state NEW

fi

