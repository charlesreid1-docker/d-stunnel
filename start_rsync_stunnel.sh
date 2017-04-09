#!/bin/bash

echo "ssyncd 443/tcp" >> /etc/services

/usr/bin/stunnel

tail -f /dev/null
