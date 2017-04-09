#!/bin/bash
# 
# Run the rsync stunnel container
# on the server.
#
# Note: to run interactively, 
# add foreground = yes to stunnel.conf

function usage {
	echo ""
	echo "run_rsync.sh script:"
	echo "run the rsync stunnel docker container."
	echo "specify a port number for rsync stunnel to open:"
	echo ""
	echo "        ./run_rsync.sh 666"
	echo ""
}

if [[ "$#" -ne 1 || $1 =~ "[0-9]\{1,5\}" ]];
then
	usage
else

	docker run \
		--network=host \
		-p ${1}:${1} -p 873:873 \
		-d \
		-ti cmr_stunnel_rsync

fi

