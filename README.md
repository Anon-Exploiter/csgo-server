## CS:GO Server with Sourcemod (Bash installation & Docker image)
Creating CS:GO server with skins, ws, gloves, knifes, !rank, !rs, etc. both with a bash file and using a docker file.  

### Manually (recommended way)
If you manually want to build the server, it is highly recommended to use [csgo.sh](https://github.com/Anon-Exploiter/csgo-server/blob/master/csgo.sh):

The bash file contains instructions for
- Setting up CS:GO server
- Setting up Sourcemod & Metamod
- Installing skins, rs, etc.
- Setting up GSLT & AUTHKEY usage in a .sh file
- Invoking of a single file to run it all! 

### Docker Image
Make sure to build the image rather than cloning the built image already since that one will be outdated. I'd recommend using the bash script over this since the docker container won't store any user data! -- Is good for one time use only. 

The docker image can be built using the following:
```bash
git clone https://github.com/Anon-Exploiter/csgo-server/
cd csgo-server/
docker build -t uexpl0it/csgo-server .
docker run -it --rm \
    --env "ACCESS_TOKEN=AAAAAAAAAAAAAAAAAAAAAAA" \
    --env "MAP=de_shortdust" \
    --network=host \
    uexpl0it/csgo-server 
```

### Instructions
* You need to replace ACCESS_TOKEN's value with your GSLT token which can be grabbed from: https://steamcommunity.com/dev/managegameservers
* The instance should have atleast 1 GB RAM, 2 cores, and 30 GB space for the container to run

### Why create this?
The reason of creating this `repo` was to simplify the steps of creating a **CS:GO server on linux**. Manually, on the first time, it took me around 3-4 hours to setup everything with sourcemod, metamod, and plugins.

The bash file contains instructions for setting up everything! 

### Contribution/Errors
Report any errors with details or PR if whenever you come across one to make the container/manual better. Also, if you think a plugin is usefull and isn't in this repo, let me know, I'll work on integrating it. 
