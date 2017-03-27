#!/bin/sh
# 
# Run the docker container

docker run \
	--network=host \
	-ti cmr_stunnel \
	/bin/bash

