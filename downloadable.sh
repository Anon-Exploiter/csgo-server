#!/bin/bash

### Note
# This file requires you to have setup your own cs:go download server for
# files download required for the plugins below to work!!! 

# For now I've added sv_downloadurl "https://s3.wasabisys.com/csgo/csgo"
# in autoexec.cfg file being downloaded -- It contains all the files.
###


# Print all commands (for better debugging)
set -x


# Setting variables required while running server:
source config.sh


# Setting up "Fortnite like damage" plugin - https://forums.alliedmods.net/showthread.php?t=309218
cd /tmp/ && \
    download "https://forums.alliedmods.net/attachment.php?attachmentid=170606&d=1532301560" -o "fortnite_hits_1.2.0.zip" && \
    cd "fortnite_hits_1.2.0" && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/fortnite_hits_1.2.0 /tmp/fortnite_hits_1.2.0.zip

