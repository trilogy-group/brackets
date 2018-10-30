# Brackets Docker Development Environment

## Brackets Development Docker image

The DockerImage is created from the Dockerfile based on `ubuntu:18.04` image. Git, NodeJS, npm and other basic developer tools are available in the image. 

The image is located at `registry2.swarm.devfactory.com/devfactory/brackets/brackets-ds:latest`.  Please refer to the section *Build the DevSpaces Docker image* for more information.

# Quick Start Using Docker-Compose

- Switch to the `{brackets-project-root-folder}/docker-ds` or extract the contents of the Brackets Dockerization artifacts to the  `{brackets-project-root-folder}/docker-ds` directory.  Notes: See *Brackets Repository Dependencies*
- Open a terminal session to that folder.  Run `./docker-cli start` : Build and run the containers
- Run `./docker-cli exec`
- At this point you must be inside the docker container, in the root folder of the project in the container (i.e.: `/data`). From there, you can build the repository as usual:
    - `npm install --unsafe-perm` to generate the NodeJS dependencies.  This will generates dependencies contents under  `{brackets-project-root-folder}/node_modules`
    - `grunt build` to build Brackets.  This will generates build contents under  `{brackets-project-root-folder}/dist`
    - See the section *Using Brackets* for details on how to use Brackets Docker container for running the Brackets Server
- When you finish working with the container, type `exit`
- Run `./docker-cli stop` to stop the service or `./docker-cli down` to stop the container and remove the image/network. 


# Quick Start Using DevSpaces

- Switch to the `{brackets-project-root-folder}/docker-ds` or extract the contents of the Brackets Dockerization artifacts to the  `{brackets-project-root-folder}/docker-ds` directory.  Notes: See *Brackets Repository Dependencies*
- Open a terminal session to that folder.  Run `./devspaces-cli start` : Create DevSpaces collection, deploy the container into DevSpaces environment and sync the `{brackets-project-root-folder}/` root directory with the container `/data` .
- Run `./devspaces-cli exec`
- At this point you must be inside the docker container, in the root folder of the project in the container (i.e.: `/data`). From there, you can build the repository as usual:
    - `npm install --unsafe-perm` to generate the NodeJS dependencies.  This will generates dependencies contents under  `{brackets-project-root-folder}/node_modules`
    - `grunt build` to build Brackets.  This will generates build contents under  `{brackets-project-root-folder}/dist`
    - See the section *Using Brackets* for details on how to use Brackets Docker container for running the Brackets Server
- When you finish working with the container, type `exit`
- Run `./devspaces-cli stop` to stop the collections or `./devspaces-cli down` to stop the collection and delete the collection from DevSpaces. 


# Work with Brackets Development Docker using Docker-Compose

Change directory to the  `{brackets-project-root-folder}/docker-ds/`.  A helper script `docker-cli` is provided to simplify the commands.  Running `docker-cli` without arguments will give a list of possible options.

## Build and Run the container

In `{brackets-project-root-folder}/docker-ds/` folder, run:

```
./docker-cli start
```
This command will use the Dockerfile to create a Docker image and then start the container in detached mode.

### Build the container

In `{brackets-project-root-folder}/docker-ds/` folder, run:

```
./docker-cli build
```
This command will use the Dockerfile and create a Docker image complete with all the tools to build and run Brackets.

### Run the container

In `{brackets-project-root-folder}/docker-ds/` folder, run:

```
./docker-cli up
```
This command will create a running container in detached mode called `brackets-dev`.
You can check the containers running with `./docker-cli info`

## Get a container session

Run:

```
./docker-cli exec
```

This will launch an interactive `bash` session into the `brackets-dev` container.

## Stop/Remove the container

In `{brackets-project-root-folder}/docker-ds/` folder, run:

```
./docker-cli stop
```
This command will create a stop the container.

```
./docker-cli down
```

This command will stop and remove the container.

## docker-compose.yml

The docker-compose.yml file contains a single service: `brackets-dev`.  We will use this service to build the Brackets sources from our local environment, so we mount the Brackets root project dir to the a `/data` folder:

```
    volumes:
      - ../.:/data:Z
```

## Requirements
The container was tested successfully on:
- Docker 17.05 and up
- docker-compose 1.8 and up


# Work with the DevSpaces for Brackets

Install the DevSpaces CLI from [here](http://devspaces-docs.ey.devfactory.com/installation/index.html#installation) as the first step.

Change directory to the  `{brackets-project-root-folder}/docker-ds/`.  A helper script `devspaces-cli` is provided to simplify the commands.  Running `devspaces-cli` without arguments will give a list of possible options.

The most useful commands are listed below.

## Create, deploy and sync the project root directory to DevSpaces Collection for Brackets

```
./devspaces-cli start
```
This will create the DevSpaces collection for Brackets development, deploy it in DevSpaces development environment then synchronize with the `{brackets-project-root-folder}` with the container `/data` directory.  You can log into the [DevSpaces UI Console](https://devspaces.ey.devfactory.com/home/collections) and checks its collection as well as the DevSpaces Image that it uses and its states.

The `./devspaces-cli start` is the combination of 
###  Create the  DevSpaces collection for Brackets 

```
./devspaces-cli [create|build]
```


###  Run DevSpaces container and Sync the Brackets local repos with the Devspaces Container 

```
./devspaces-cli [bind|up]
```
Deploy the collection in DevSpaces development environment then synchronize with the `{brackets-project-root-folder}` with the container `/data` directory if it is not already done.


## Get a container session for Brackets DevSpaces 

Run:

```
./devspaces-cli exec
```

##  Update the DevSpace collection using the brackets-collection.yaml 

```
./devspaces-cli update
```

##  Stop the DevSpaces collection for Brackets 

```
./devspaces-cli stop
```

##  Stop and Delete the DevSpaces collection for Brackets 

```
./devspaces-cli down
```

##  Obtaining deployment information of the DevSpaces collection for Brackets 

```
./devspaces-cli info
```

## Build the DevSpaces Docker image

The DevSpaces DockerImage has already been pre-created, if you need to recreate it again, in `{brackets-project-root-folder}/docker-ds/` folder, run:

```
./build_ds_img.sh
```
This instruction will create a DockerImage in the Docker Registry `registry2.swarm.devfactory.com` as `registry2.swarm.devfactory.com/devfactory/brackets/brackets-ds:latest`

# Brackets Repository Dependencies
The checkout of the Brackets repository requires a 2-steps process:

- Clone the main repository: `git clone git@github.com:trilogy-group/brackets.git`
- Check out the repository 3rd-Party build dependencies submodules : `cd brackets && git submodule update --init`

Failure to checkout the submodules will ended up with strange compilation errors.

As part of the build, grunt will also attempts to checkout Git dependencies so you also needed to provide Git credentials in the DevSpaces/Docker build containers.

# Using Brackets Server

The Bracket servers are built upon a collections of HTML, CSS and JavaScript.  To run, it requires a CEF3 shell.  There is an custom CEF3 application shell made specific for Brackets in `https://github.com/adobe/brackets-shell`.  To run the Brackets development build with the shell, it sufficed to download and install the Brackets from http://brackets.io/ on your system and then uses the build `tools/setup_for_hacking.[bat|sh]` scripts to configure/restore Brackets to use/restore your build artifacts.  For more details please consult https://github.com/adobe/brackets/wiki/How-to-Hack-on-Brackets

To launch the built Brackets Server, simply run

- Download Brackets from http://brackets.io/ and install it
- Open a terminal and change directory to `<Brackets Server development repository>/tools`
- Execute `./setup_for_hacking.[sh|bat] <path of Installed Brackets>`
- Run `brackets` : the new shell is now using your development build artifacts.

To revert back to your downloaded Brackets binaries, use `./restore_installed_build.[sh|bat] <path of Installed Brackets>`
