#!/bin/bash
# 
# Run the docker container
# 
# http://charlesreid1.com/wiki/Docker/Basics

docker run \
	--network=host \
	-p 443:443 -p 22:22 \
	-ti cmr_stunnel 

