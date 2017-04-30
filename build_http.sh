#!/bin/bash
#
#################################
# do not call this script directly.
# use the Makefile.
#################################
#
# Build the http docker container using the Dockerfile
# 
# https://charlesreid1.com/wiki/Docker/Dockerfiles

SED="/bin/sed"

function usage {
	echo ""
	echo "build_http.sh script:"
	echo "builds an http stunnel docker container."
	echo "specify a port number for the stunnel server to use:"
	echo ""
	echo "        ./build_http.sh 666"
	echo ""
}

if [[ "$#" -ne 1 || $1 =~ "[0-9]\{1,5\}" ]];
then
	usage
else

	CERT="fullchain.pem"
	KEY="privkey.pem"

	CONF="stunnel.conf"
	THIS_CONF="stunnel.server.http.conf"

	STARTSCRIPT="start_http_stunnel.sh"
	DOCKERFILE="Dockerfile"

	if [ -f $CERT -a -f $KEY -a -f $THIS_CONF ]; then
		$SED "s/PORT/${1}/g" ${THIS_CONF} > ${CONF}
		$SED -i "s/EXPOSE [0-9]\{1,5\}/EXPOSE ${1}/g" ${DOCKERFILE}
		docker build -f ${DOCKERFILE} -t cmr_stunnel_http .

	else
		echo "http stunnel docker container build script:"
		echo "Missing one of the following:"
		echo "${CERT}, ${KEY}, ${THIS_CONF}"
		echo ""
		echo "Copy an example stunel configuration file, or use your own."
		echo "Check /etc/letsencrypt/live/domain.com/ or /etc/ssl/ for certificates."
	fi

fi

