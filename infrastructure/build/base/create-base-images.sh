#!/bin/bash

# create-base-images.sh
# build and push the base container image to the container registry
#
# in this instance, DockerHub is used
# note: DockerHub must be available (login via: "docker login")

# construct the base container image names
dockerHubAct="reallymovinggroup"
dockerHubRpo="tls-demo"
imgDatestamp=$(date '+%Y%m%d')

# build and push the base container image for "web" (don't build for linux/amd64 in K3S)
dockerHubImg="web-base"
dockerHubImg=$dockerHubAct/$dockerHubRpo:$dockerHubImg-$imgDatestamp
echo "[INFO] : Will build and push : $dockerHubImg"
docker buildx build . -f Dockerfile.web --no-cache --platform linux/arm64 --tag $dockerHubImg
docker push                                       $dockerHubImg

# build and push the base container image for "app" (don't build for linux/amd64 in K3S)
dockerHubImg="app-base"
dockerHubImg=$dockerHubAct/$dockerHubRpo:$dockerHubImg-$imgDatestamp
echo "[INFO] : Will build and push : $dockerHubImg"
docker buildx build . -f Dockerfile.app --no-cache --platform linux/arm64 --tag $dockerHubImg
docker push                                       $dockerHubImg