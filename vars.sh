GSLT=''                                         # For setting up community server - 730 -- https://steamcommunity.com/dev/managegameservers
AUTHKEY=''                                      # For downloading filse from workshop   -- https://steamcommunity.com/dev/apikey
CSGO_INSTALL_LOCATION="/home/$USER/csgo-ds"     # Installation directory
EXEC_PTH=`pwd`

# Setting variables for CS:GO sourcemod config files
STEAMID=''                                      # Your SteamId to add you as a admin on sourcemod installation -- https://steamid.io/lookup
SERVERNAME=""                                   # Server name
RCONPSWD=''                                     # Rcon password while setting up cs:go

# For downloading of files
download() {
    aria2c -s 10 -j 10 -x 16 $@ --file-allocation=none -c   
}