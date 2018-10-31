#!/bin/bash

IMAGE=registry2.swarm.devfactory.com/devfactory/brackets/brackets-ds
# In the case of updated/new feature to this Docker image, please increment the VERSION number
VERSION=v1

docker -H tcp://build.swarm.devfactory.com build -f Dockerfile -t $IMAGE:$VERSION -t $IMAGE:latest .
docker -H tcp://build.swarm.devfactory.com push $IMAGE:latest
docker -H tcp://build.swarm.devfactory.com push $IMAGE:$VERSION
