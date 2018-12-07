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

## Software Requirements

All Operating Systems:

- docker

On Mac OS X and Windows:

- reprounzip
- reprounzip-docker

(provided you don't want to figure out how to access the docker api on the host
from within the container on Windows and Mac OS X)

## Instructions

Use the `Makefile` in the root of the project.

## Contents

- `Dockerfile` - instructions for building an image that has `reprozip` and
  `reprounzip` in it. Used to build and run reprozips archives.
