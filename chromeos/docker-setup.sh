#!/bin/bash

apt-get update
apt-get -y install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

if [[ $(apt-key fingerprint 0EBFCD88) ]]; then 
	echo "finger added."
else
       	echo "finger not added."
	exit 1
fi

add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"

apt-get update

apt-get -y install docker-ce

docker run hello-world

groupadd docker
usermod -aG docker $USER
