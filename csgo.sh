#!/bin/bash

# Print all commands (for better debugging)
set -x

# Setting variables required while running server:
GSLT='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'            # For setting up community server - 730 -- https://steamcommunity.com/dev/managegameservers
AUTHKEY='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'            # For downloading filse from workshop   -- https://steamcommunity.com/dev/apikey
CSGO_INSTALL_LOCATION="/home/$USER/csgo-ds"         # Installation directory

# Setting variables for CS:GO sourcemod config files
STEAMID='STEAM_0:1:11111111'                # Your SteamId to add you as a admin on sourcemod installation -- https://steamid.io/lookup
SERVERNAME='Bruh server'                    # Server name you want to appear in searches // connecting
RCONPSWD='plsdontguessthispls'              # Rcon password while setting up cs:go

# Update & Upgrade -- Add i386 architecture support for steam libraries
sudo apt-get -y update && \
    sudo apt-get -y upgrade && \
    sudo apt install unzip zip software-properties-common && \
    sudo add-apt-repository multiverse && \
    sudo dpkg --add-architecture i386 && \
    sudo apt-get -y update && \
    sudo apt-get -y upgrade

# Installing steamcmd for installation of csgo
sudo apt-get -y install steamcmd

# Installing csgo server in ~/csgo/ directory
steamcmd +login anonymous +force_install_dir $CSGO_INSTALL_LOCATION +app_update 740 +quit

# Creating auto-startup bash file for ease while setting up
rm -rfv /home/$USER/startcsgo.sh && \
    touch /home/$USER/startcsgo.sh && \
    echo '#!/bin/sh' >> /home/$USER/startcsgo.sh && \
    echo 'MAP=workshop/2078097114/1v1_awp' >> /home/$USER/startcsgo.sh && \
    echo "cd $CSGO_INSTALL_LOCATION" >> /home/$USER/startcsgo.sh && \
    echo "./srcds_run -game csgo -usercon +game_type 0 +game_mode 1 +mapgroup mg_active +map $MAP -hltv +tv_enable 1 -tickrate 128 +sv_setsteamaccount $GSLT -net_port_try 1 -authkey $AUTHKEY +host_workshop_map 2078097114" >> /home/$USER/startcsgo.sh && \
    chmod +x /home/$USER/startcsgo.sh

# Downloading and setting up sourcemod
cd /tmp/ && \
    wget https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6502-linux.tar.gz --no-clobber && \
    tar -xvf sourcemod-1.10.0-git6502-linux.tar.gz -C "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/sourcemod-1.10.0-git6502-linux.tar.gz

# Downloading and setting up metamod
cd /tmp/ && \
    wget https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1144-linux.tar.gz --no-clobber && \
    tar -xvf mmsource-1.11.0-git1144-linux.tar.gz -C "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/mmsource-1.11.0-git1144-linux.tar.gz

# Adding user as admin in sourcemod config
cd "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/configs" && \
    echo "" >> admins_simple.ini && \
    echo "\"$STEAMID\" \"99:z\"" >> admins_simple.ini

# PTAH installation is required prior to installation of the weapons plugin
cd /tmp/ && \
    wget https://ptah.zizt.ru/files/PTaH-V1.1.3-build20-linux.zip --no-clobber && \
    unzip PTaH-V1.1.3-build20-linux.zip -d ptah && \
    cd ptah && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/PTaH-V1.1.3-build20-linux.zip /tmp/ptah

# Downloading and setting up knife, gloves, and guns skins (!ws, !gloves && !knife)
cd /tmp/ && \
    wget https://github.com/kgns/weapons/releases/download/v1.7.1/weapons-v1.7.1.zip --no-clobber && \
    unzip weapons-v1.7.1.zip -d wpns && \
    cd wpns && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/weapons-v1.7.1.zip /tmp/wpns

# Changing server variable to let the knife and other plugins to load
sed -i -e 's:"FollowCSGOServerGuidelines"\t"yes":"FollowCSGOServerGuideLines"\t"no":g' "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/configs/core.cfg"

# Setting up reset score plugin (!rs or !resetscore)
cd /tmp/ && \
    wget https://github.com/abnerfs/abner_resetscore/archive/refs/heads/master.zip --no-clobber -O reset-score.zip && \
    unzip -o reset-score.zip && \
    cd abner_resetscore-master/ && \
    cp scripting/ translations/ -rv "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/" && \
    rm -rfv /tmp/reset-score.zip /tmp/abner_resetscore-master/

# Downloading and settuping up rank plugins (!rank !top ..)
cd /tmp/ && \
    wget https://github.com/rogeraabbccdd/Kento-Rankme/archive/refs/heads/master.zip --no-clobber -O rank-score.zip && \
    unzip -o rank-score.zip && \
    cd Kento-Rankme-master/ && \
    cp scripting/ translations/ plugins/ -rv "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/" && \
    rm -rfv /tmp/rank-score.zip /tmp/Kento-Rankme-master/

## End of plugins

# Finally calling the .sh file and running csgo server
echo
echo "[#] Run CSGO server by following:"
echo "cd && bash startcsgo.sh"
echo