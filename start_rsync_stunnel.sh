#!/bin/bash

echo "ssyncd 273/tcp" >> /etc/services

/usr/bin/stunnel

tail -f /dev/null
