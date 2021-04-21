## CS:GO Docker image
Creating CS:GO server with skins, ws, gloves, knifes, etc. on a Ubuntu Instance in a Docker Container

### Manually
If you manually want to build the server, you can use the following bash instructions to do so: https://gist.github.com/Anon-Exploiter/7016b21246e4b9630bc81f83cbb54144

### Docker Image
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

### Contribution/Errors
Report any errors with details or PR if whenever you come across one to make the container/manual better.

### ToDos
* Build the docker image from docker hub using this repo's Dockerfile
* Upload the built image on Docker hub

### Reason
The reason of creating this repo was to simplify the steps of creating a CS:GO server on linux. Manually, it took me around 3 hours to setup everything with sourcemod, metamod, and skins. This repository manual/container contains file named "backup.tgz" which has everything required. 
