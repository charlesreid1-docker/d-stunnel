#!/bin/bash
# 
# Run the http stunnel docker container
# on the server.
#
# Note: to run interactively, 
# add foreground = yes to stunnel.conf

function usage {
	echo ""
	echo "run_http.sh script:"
	echo "run the http stunnel docker container."
	echo "specify a port number for http stunnel to open:"
	echo ""
	echo "        ./run_http.sh 666"
	echo ""
}

if [[ "$#" -ne 1 || $1 =~ "[0-9]\{1,5\}" ]];
then
	usage
else

	echo "Running http stunnel docker container on port ${1}"

	docker run \
		--network=host \
		-p ${1}:${1} -p 22:22 \
		-d \
		-ti cmr_stunnel_http

fi


