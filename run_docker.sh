#!/bin/sh
# 
# Run the docker container
# 
# http://charlesreid1.com/wiki/Docker/Basics

docker run \
	--network=host \
	-p 273:273 -p 873:873 \
	-ti cmr_stunnel \
	/bin/bash

