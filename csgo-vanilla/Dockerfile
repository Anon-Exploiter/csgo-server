FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

ENV USER csgo
ENV HOME /home/$USER
ENV SERVER $HOME/csgo-ds

RUN apt-get -y update && \
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

RUN cd $HOME/config/ && \
	wget "http://media.steampowered.com/client/steamcmd_linux.tar.gz" && \
	tar -xvf steamcmd_linux.tar.gz && \
	rm -rfv steamcmd_linux.tar.gz

RUN cd $HOME/config/ && \
	./steamcmd.sh +force_install_dir $SERVER +login anonymous +app_update 740 +quit