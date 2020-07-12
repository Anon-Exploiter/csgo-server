FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

ENV USER csgo
ENV HOME /home/$USER
ENV SERVER $HOME/csgo-ds

ENV RUN startcsgo.sh

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install software-properties-common && \
	add-apt-repository -y multiverse && \
	dpkg --add-architecture i386 && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install lib32gcc1 lib32stdc++6 wget

RUN adduser --gecos "" --disabled-login $USER && \
	mkdir -p $HOME && \
	mkdir -p $SERVER && \
	mkdir -p $HOME/config/ && \
	chown $USER:$USER -R $HOME

WORKDIR $HOME
USER $USER

EXPOSE 27015/udp
EXPOSE 27015/tcp

EXPOSE 27020/tcp
EXPOSE 27020/udp

RUN cd $HOME/config/ && \
	wget "http://media.steampowered.com/client/steamcmd_linux.tar.gz" && \
	tar -xvf steamcmd_linux.tar.gz && \
	rm -rfv steamcmd_linux.tar.gz

RUN cd $HOME/config/ && \
	./steamcmd.sh +force_install_dir $SERVER +login anonymous +app_update 740 +quit

RUN cd /home/csgo/csgo-ds/csgo/ && \
	wget "https://files.slack.com/files-pri/T8QQ11A0M-F016YJYCQHH/download/backup.tgz?pub_secret=9de27178c8" -O backup.tgz && \
	tar -xvf backup.tgz && \
	rm -rfv backup.tgz

RUN touch $HOME/$RUN && \
	echo '#!/bin/sh' >> $HOME/$RUN && \
	echo 'YOUR_GSLT=${ACCESS_TOKEN}' >> $HOME/$RUN && \
	echo 'MAP=${MAP}' >> $HOME/$RUN && \
	echo 'CSGO_INSTALL_LOCATION=~/csgo-ds/' >> $HOME/$RUN && \
	echo 'cd $CSGO_INSTALL_LOCATION' >> $HOME/$RUN && \
	echo './srcds_run -game csgo -usercon +game_type 0 +game_mode 1 +mapgroup mg_active +map $MAP -tickrate 128 +sv_setsteamaccount $YOUR_GSLT -net_port_try 1 -nobots' >> $HOME/$RUN  && \
	chmod +x $HOME/$RUN

CMD ["bash", "-c", "/bin/bash startcsgo.sh"]