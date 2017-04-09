#!/bin/bash
# 
# Run the docker container
# 
# http://charlesreid1.com/wiki/Docker/Basics

# Note: to run interactively, 
# add foreground = yes to stunnel.conf

docker run \
	--network=host \
	-p 443:443 -p 22:22 \
	-d \
	-ti cmr_stunnel 

