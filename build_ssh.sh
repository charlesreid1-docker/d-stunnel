#!/bin/bash
#
#################################
# do not call this script directly.
# use the Makefile.
#################################
#
# Build the ssh docker container using the Dockerfile
# 
# https://charlesreid1.com/wiki/Docker/Dockerfiles

SED="/bin/sed"

function usage {
	echo ""
	echo "build_ssh.sh script:"
	echo "builds an ssh stunnel docker container."
	echo "specify a port number for the ssh stunnel server to use:"
	echo ""
	echo "        ./build_ssh.sh 666"
	echo ""
}

if [[ "$#" -ne 1 || $1 =~ "[0-9]\{1,5\}" ]];
then
	usage
else

	CERT="fullchain.pem"
	KEY="privkey.pem"

	CONF="stunnel.conf"
	THIS_CONF="stunnel.server.ssh.conf"

	STARTSCRIPT="start_ssh_stunnel.sh"
	DOCKERFILE="Dockerfile_ssh_stunnel"

	if [ -f $CERT -a -f $KEY -a -f $THIS_CONF ]; then
		$SED "s/PORT/${1}/g" ${THIS_CONF} > ${CONF}
		$SED -i "s/EXPOSE [0-9]\{1,5\}/EXPOSE ${1}/g" ${DOCKERFILE}
		docker build -f ${DOCKERFILE} -t cmr_stunnel_ssh .

	else
		echo "ssh stunnel docker container build script:"
		echo "Missing one of the following:"
		echo "${CERT}, ${KEY}, ${THIS_CONF}"
		echo ""
		echo "Copy an example stunel configuration file, or use your own."
		echo "Check /etc/letsencrypt/live/domain.com/ or /etc/ssl/ for certificates."
	fi

fi


