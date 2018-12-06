# Software Requirements

All Operating Systems:

- docker

On Mac OS X and Windows:

- reprounzip
- reprounzip-docker

(provided you don't want to figure out how to access the docker api on the host
from within the container on Windows and Mac OS X)

# Overview

Reprozip and reprounzip are packages for creating, bundling and executing
experiments.

This example packages `reprozip` itself in docker because `reprozip` only
works on Linux. `reprounzip` works on Windows, Mac OS X and Linux so it
does not need to be  included in the Dockerfile. `reprounzip` also uses 
docker to run experiments so having `reprounzip` installed on the installed
directly on your machine avoids having to docker installed in the docker
container or exposing access to the Docker API from your host computer to your
container.

# Instruction

Setup the project. This downloads the Mesa model `boltzmann_wealth_model_network`
and places it in the current directory. It builds the Docker image with 
`reprozip` in it.

```
./reprozip_demo.sh setup
```

## Build a Reprozip archive of your experiment run

Create and enter a container built on the previously created `reprozip` image

```
./reprozip_demo.sh run 
# On Windows and Mac OS X just run
# docker run -it --rm -v .:/data -p 127.0.0.1:8521:8521 boltzmann-model-reprozip bash
# Instead
```

Trace a interactive model run

```
cd boltzmann
reprozip trace python3 -m boltzmann_wealth_model_network.headless_run
```

This will start the Mesa model non interactively.

Reprozip should now have archived the dependencies for your run of the model.
To save the dependencies in an archive run

```
reprozip pack
```

This will create a file called `experiment.rpz` in the current directory.

## Run the experiment recorded in the Reprozip archive

Since you have `reprounzip` and `reprounzip-docker` installed on your base
system if you've exited the container you can run

```
reprounzip docker run experiment.rpz
```

to rerun the experiment.
