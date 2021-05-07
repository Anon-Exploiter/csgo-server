#!/bin/bash

##
# This setup file is supposed to create 1v1 server with 1v1 maps
# More details can be found at https://github.com/splewis/csgo-multi-1v1
##

# Setting variables required while running server:
source my.sh

# Downloading and setting up 1v1 plugin
cd /tmp && \
	download https://ci.splewis.net/job/csgo-multi-1v1/lastSuccessfulBuild/artifact/builds/multi1v1-release/multi1v1-220.zip && \
	unzip -o multi1v1-220.zip -d multi1v1 && \
	cd multi1v1 && \
	rm -rfv CHANGELOG.md LICENSE README.md && \
	cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
	rm -rfv /tmp/multi1v1-220.zip /tmp/multi1v1