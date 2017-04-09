#!/bin/bash
# 
# Generate you some certificates
# from Lets Encrypt
#
# This will go into /etc/letsencrypt/keys
#
# https://charlesreid1.com/wiki/LetsEncrypt

export WEBROOT="/var/www/html"
export URL="reidmachine.party"

add-apt-repository ppa:certbot/certbot
apt-get update
apt-get -y install certbot
certbot certonly --webroot -w ${WEBROOT} -d ${URL}