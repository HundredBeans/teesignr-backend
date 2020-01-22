#!/bin/bash

eval "$(ssh-agent -s)" &&
ssh-add -k ~/.ssh/id_rsa &&
cd ~/test-travis/backend
git pull

source ~/.profile
echo "$DOCKERHUB_PASS" | docker login --username $DOCKERHUB_USER --password-stdin
docker stop teesignrBE
docker rm teesignrBE
docker rmi daffa99/containerd:BE2
docker run -d --name teesignrBE -p 5000:5000 daffa99/containerd:BE2

