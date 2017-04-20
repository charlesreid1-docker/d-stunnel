#!/bin/bash

echo "ssyncd 443/tcp" >> /etc/services

/usr/bin/stunnel

# run forever
tail -f /dev/null
