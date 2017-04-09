#!/bin/bash
# 
# Run the ssh stunnel docker container
# on the server.
#
# Note: to run interactively, 
# add foreground = yes to stunnel.conf

function usage {
	echo ""
	echo "run_ssh.sh script:"
	echo "run the ssh stunnel docker container."
	echo "specify a port number for ssh stunnel to open:"
	echo ""
	echo "        ./run_ssh.sh 666"
	echo ""
}

if [[ "$#" -ne 1 || $1 =~ "[0-9]\{1,5\}" ]];
then
	usage
else

	docker run \
		--network=host \
		-p ${1}:${1} -p 22:22 \
		-d \
		-ti cmr_stunnel_ssh

fi

