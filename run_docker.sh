#!/bin/sh
# 
# Run the docker container
# 
# http://charlesreid1.com/wiki/Docker/Basics

docker run \
	--network=host \
	-ti cmr_stunnel \
	/bin/bash

