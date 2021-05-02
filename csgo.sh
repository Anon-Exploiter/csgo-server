#!/bin/bash

# Print all commands (for better debugging)
set -x

# Downloading files
download() {
    aria2c -s 10 -j 10 -x 16 $@ --file-allocation=none -c   
}

# Setting variables required while running server:
source vars.sh 
# source my.sh 

# Update & Upgrade -- Add i386 architecture support for steam libraries
sudo apt-get -y update && \
    sudo apt-get -y upgrade && \
    sudo apt install unzip zip software-properties-common aria2 && \
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
    echo 'MAP=workshop/2078097114/1v1_awp' >> /home/$USER/startcsgo.sh && \ # Fav map -- do try it :D
    echo "cd $CSGO_INSTALL_LOCATION" >> /home/$USER/startcsgo.sh && \
    echo "./srcds_run -game csgo -usercon +game_type 0 +game_mode 1 +mapgroup mg_active +map \$MAP -hltv +tv_enable 1 -tickrate 128 +sv_setsteamaccount $GSLT -net_port_try 1 -authkey $AUTHKEY -autoupdate #+host_workshop_map 2078097114" >> /home/$USER/startcsgo.sh && \
    chmod +x /home/$USER/startcsgo.sh

# Downloading and setting up sourcemod
cd /tmp/ && \
    download https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6502-linux.tar.gz && \
    tar -xvf sourcemod-1.10.0-git6502-linux.tar.gz -C "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/sourcemod-1.10.0-git6502-linux.tar.gz

# Downloading and setting up metamod
cd /tmp/ && \
    download https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1144-linux.tar.gz && \
    tar -xvf mmsource-1.11.0-git1144-linux.tar.gz -C "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/mmsource-1.11.0-git1144-linux.tar.gz

# Adding user as admin in sourcemod config
cd "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/configs" && \
    echo "" >> admins_simple.ini && \
    echo "\"$STEAMID\" \"99:z\"" >> admins_simple.ini

# Downloading server & autoexec cfg files
cd "$CSGO_INSTALL_LOCATION/csgo/cfg/" && \
    curl https://raw.githubusercontent.com/Anon-Exploiter/csgo-server/master/cfgs/autoexec.cfg -O && \
    curl https://raw.githubusercontent.com/Anon-Exploiter/csgo-server/master/cfgs/server.cfg -O && \
    curl https://raw.githubusercontent.com/Anon-Exploiter/csgo-server/master/cfgs/custom.cfg -O

# Editing autoexec cfg file to add hostname and rcon passwd
sed -i -e "s:bruh:$SERVERNAME:g" "$CSGO_INSTALL_LOCATION/csgo/cfg/autoexec.cfg"
sed -i -e "s:pswd:$RCONPSWD:g" "$CSGO_INSTALL_LOCATION/csgo/cfg/autoexec.cfg"

# PTAH installation is required prior to installation of the weapons plugin
cd /tmp/ && \
    download https://ptah.zizt.ru/files/PTaH-V1.1.3-build20-linux.zip && \
    unzip PTaH-V1.1.3-build20-linux.zip -d ptah && \
    cd ptah && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/PTaH-V1.1.3-build20-linux.zip /tmp/ptah

# Downloading and setting up knife, and guns skins (!ws, !gloves && !knife)
cd /tmp/ && \
    download https://github.com/kgns/weapons/releases/download/v1.7.1/weapons-v1.7.1.zip && \
    unzip weapons-v1.7.1.zip -d wpns && \
    cd wpns && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/weapons-v1.7.1.zip /tmp/wpns

# Downloading and setting up gloves
cd /tmp/ && \
    download https://github.com/kgns/gloves/releases/download/v1.0.5/gloves-v1.0.5.zip && \
    unzip gloves-v1.0.5.zip -d gloves && \
    cd gloves && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/" && \
    rm -rfv /tmp/gloves-v1.0.5.zip /tmp/gloves

# Changing server variable to let the knife and other plugins to load
sed -i -e 's:"FollowCSGOServerGuidelines"\t"yes":"FollowCSGOServerGuideLines"\t"no":g' "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/configs/core.cfg"

# Setting up reset score plugin (!rs or !resetscore)
cd /tmp/ && \
    download https://github.com/abnerfs/abner_resetscore/archive/refs/heads/master.zip -o reset-score.zip && \
    unzip -o reset-score.zip && \
    cd abner_resetscore-master/ && \
    cp scripting/ translations/ -rv "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/" && \
    rm -rfv /tmp/reset-score.zip /tmp/abner_resetscore-master/

# Downloading and setting up rank plugins (!rank !top ..)
cd /tmp/ && \
    download https://github.com/rogeraabbccdd/Kento-Rankme/archive/refs/heads/master.zip -o rank-score.zip && \
    unzip -o rank-score.zip && \
    cd Kento-Rankme-master/ && \
    cp scripting/ translations/ plugins/ -rv "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/" && \
    rm -rfv /tmp/rank-score.zip /tmp/Kento-Rankme-master/

# Plugin to allow admin to change teams of people in the server
cd /tmp/ && \
    git clone https://github.com/JakubKosmaty/Admin-Change-Team && \
    cd Admin-Change-Team && \
    rm -rfv LICENSE README.md && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/" && \
    rm -rfv /tmp/Admin-Change-Team

# Setting up server advertisements, be sure to edit the config file downloaded!
cd /tmp/ && \
    git clone https://github.com/ESK0/ServerAdvertisement3 && \
    cd ServerAdvertisement3 && \
    cp * -rv "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/" && \
    rm -rfv /tmp/ServerAdvertisement3

curl https://raw.githubusercontent.com/Anon-Exploiter/csgo-server/master/cfgs/ServerAdvertisements3.cfg -o "$CSGO_INSTALL_LOCATION/csgo/addons/sourcemod/configs/ServerAdvertisements3.cfg"

# Finally calling the .sh file and running csgo server
# bash startcsgo.sh