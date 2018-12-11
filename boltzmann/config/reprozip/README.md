# Overview

Reprozip and reprounzip are packages for creating, bundling and executing
experiments.

## Software Requirements

All Operating Systems:

- docker

On Mac OS X and Windows:

- reprounzip
- reprounzip-docker

(provided you don't want to figure out how to access the docker api on the host
from within the container on Windows and Mac OS X)

## Instructions

Use the `Makefile` in the root of the project. Run `make reprozip-headless`
to drop into an interactive shell with reprounzip installed and an experiment
file available at `data/experiment.rpz`. Follow the instructions on the 
[reprozip](https://docs.reprozip.org/en/1.0.x/unpacking.html) website for
unpacking and exploring an experiment file.

You'll want to unpack the experiment first:

```
reprounzip docker setup experiments/experiment.rpz experiments/experiment 
# where experiments/experiment is name of the directory you want to unpack the
# experiment into
```

Now you can rerun the experiment or export any results.

## Contents

- `Dockerfile` - instructions for building an image that has `reprozip` and
  `reprounzip` in it. Used to build and run reprozips archives.
