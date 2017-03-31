#!/bin/sh
# 
# Build the docker container using the Dockerfile
# 
# https://charlesreid1.com/wiki/Docker/Dockerfiles

export CERT="fullchain.pem"
export KEY="privkey.pem"
export CONF="stunnel.conf"

if [ -f $CERT -a -f $KEY -a $CONF ]; then
	docker build -t cmr_stunnel .
else
	echo "Missing one of the following:"
	echo "stunnel.conf, fullchain.pem, privkey.pem"
	echo ""
	echo "Copy an example stunel configuration file, or use your own."
	echo "Check /etc/letsencrypt/live/domain.com/ or /etc/ssl/ for certificates."
fi
