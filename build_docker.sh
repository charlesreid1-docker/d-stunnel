#!/bin/sh
# 
# Build the docker container using the Dockerfile
# 
# https://charlesreid1.com/wiki/Docker/Dockerfiles

export CERT="fullchain.pem"
export KEY="privkey.pem"

if [ -f $CERT -a -f $KEY ]; then
	cp stunnel.server.ssh_over_443.conf stunnel.conf
	docker build -t cmr_stunnel .
else
	echo "Missing fullchain.pem and privkey.pem - check /etc/letsencrypt/live/domain.com/"
fi
