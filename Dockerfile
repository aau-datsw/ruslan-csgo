FROM ubuntu:18.04
MAINTAINER Frederik Spang <frederik at progras.dk>

ENV USER csgo
ENV HOME /home/$USER
ENV SERVER $HOME/csserver
ENV SHELL /bin/bash

WORKDIR $HOME

RUN chsh -s /bin/bash

RUN dpkg --add-architecture i386 \
  && echo steam steam/question select "I AGREE" | debconf-set-selections \
  && echo steam steam/license note '' | debconf-set-selections \
  && apt-get update \
  && apt-get install --no-install-recommends -y \
    lib32gcc1 \
    lib32stdc++6 \
    ca-certificates \
    libtinfo5:i386 \
    libncurses5:i386 \
    libcurl3-gnutls:i386 \
    steamcmd \
  && rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/games/steamcmd steamcmd

# Install CSGO
RUN ./steamcmd +login anonymous +force_install_dir $SERVER +app_update 740 validate +quit

# Contains wrapper scripts and .cfg files
COPY containerfs/metamod $SERVER/csgo
COPY containerfs/sourcemod $SERVER/csgo
COPY containerfs/steamworks $SERVER/csgo
COPY containerfs/get5 $SERVER/csgo
COPY containerfs/custom_config $SERVER/csgo/cfg

COPY containerfs/match.json $SERVER/csgo/match.json
COPY containerfs/start.sh $SERVER/start.sh

# Fix for missing library
RUN mkdir -p $HOME/.steam/sdk32
RUN ln -s $HOME/csserver/bin/steamclient.so $HOME/.steam/sdk32/steamclient.so

WORKDIR $SERVER

CMD ["./start.sh"]
