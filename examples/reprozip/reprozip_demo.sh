#!/usr/bin/env bash

case "$1" in
  "build")
    docker build -t boltzmann-model-reprozip -f Dockerfile ..
    ;;
  "run")
    # Under Linux we can mount the Docker socket into the container to avoid having to install
    # reprounzip locally
    docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/results:/app/data \
	    --cap-add=SYS_PTRACE -p 127.0.0.1:8521:8521 boltzmann-model-reprozip bash
    ;;
  "run_non_linux")
    docker run -it --rm -v $PWD/results:/app/data -p 127.0.0.1:8521:8521 boltzmann-model-reprozip bash
    ;;
esac
