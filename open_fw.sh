#!/bin/bash
#
# Run this on the server - 
# either the server that runs stunnel,
# or the server that runs the docker stunnel container.
#
port="443"
iptables -A INPUT -p tcp --dport ${port} -j ACCEPT
iptables -A FORWARD -p tcp -j ACCEPT --dport ${port} -m state --state NEW
