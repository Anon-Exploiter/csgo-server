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


# Setting up "FaceIt Levels on scoreboard" plugin - https://forums.alliedmods.net/showthread.php?p=2727956
cd /tmp/ && \
    download https://github.com/Sarrus1/FaceitLevels-for-kento-RankMe/archive/refs/heads/master.zip -o faceit.zip && \
    unzip -o faceit.zip && \
    cd FaceitLevels-for-kento-RankMe-master/ && \
    cp addons materials -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/faceit.zip /tmp/FaceitLevels-for-kento-RankMe-master/


# Setting up "Scoreboard ranks (i.e. GE, LEM, etc.)" plugin
cd /tmp/ && \
    download https://github.com/luis-rei97/MatchMaking-Ranks-By-Points/archive/refs/heads/master.zip -o match.zip && \
    unzip -o match.zip && \
    cd MatchMaking-Ranks-By-Points-master/ && \
    cp addons cfg materials sound -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/match.zip /tmp/MatchMaking-Ranks-By-Points-master/