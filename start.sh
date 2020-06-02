#!/bin/bash

set -e
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

if ! command_exists docker; then
    apt-get -y update
    apt-get -y --no-install-recommends --fix-missing install apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    # install docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
fi
docker version

if ! command_exists docker-compose; then
    # install docker-compose
    curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi
docker-compose --version

# create base folders
mkdir -p /data/overwall/{https/{conf,certs},v2ray}

# create proxy network
docker network create nginx-proxy || true

# start v2ray
cp v2ray/config.json /data/overwall/v2ray/
docker-compose -f docker-compose.https.yml up -d
docker-compose up -d
