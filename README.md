## CS:GO Server with Sourcemod (Bash installation & Docker image)
Creating CS:GO server with skins, ws, gloves, knifes, !rank, !rs, etc. both with a bash file and using a docker file.  

**Note:** The `Dockerfile` and `docker building` instructions will be moved to another repository, this repository will mainly serve installation without docker image creation (all to keep it simple).

The `bash` file contains instructions for
- Setting up CS:GO server
- Setting up Sourcemod & Metamod
- Installing skins, rs, etc.
- Setting up GSLT & AUTHKEY usage in a .sh file
- Invoking of a single file to run it all! 

### Installation instructions (populating [vars.sh](https://github.com/Anon-Exploiter/csgo-server/blob/master/vars.sh))
* Need to add `GSLT token` for creating community server which can be grabbed from: https://steamcommunity.com/dev/managegameservers
* Need to add `AUTHKEY` for downloading workshop maps which can be grabbed from: https://steamcommunity.com/dev/apikey
* ...

### Why create this?
The reason of creating this `repo` was to simplify the steps of creating a **CS:GO server on linux**. Manually, on the first time, it took me around 3-4 hours to setup everything with sourcemod, metamod, and plugins.

The bash file contains will setup everything! 

### Todos
- Implement arguments in the script
- Beautifying the script
- Adding screenshots and more details in README.md

### Contribution/Errors
Report any errors with details or PR if whenever you come across one to make the container/manual better. Also, if you think a plugin is usefull and isn't in this repo, let me know, I'll work on integrating it. 
