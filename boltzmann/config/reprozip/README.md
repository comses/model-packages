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

## Overview

`reprozip ` is a package for tracing experiments. It is run on the command line
and uses the [PTRACE](http://www.man7.org/linux/man-pages/man2/ptrace.2.html#NAME)
system call to identity what the dependencies of an experiment (in this case a run
of the Mesa Boltzmann wealth network model). This means it an experiment should contain
all the files necessary to run on another another computer. This includes system and
library dependencies, source code as well as input and output data.

`reprounzip` is a package for unpacking experiments and inspecting experiments made
by `reprozip`. There are a number of different unpackers for `reprounzip`. This
example mostly uses the `docker` unpacker but you may want to use some of the other
examples in your own work.

### Common Reprozip Commands

```bash
reprozip trace <cmd> # trace a script run with reprozip
```

### Common Reprounzip Commands

```bash
# unpack an experiment made by reprozip
reprounzip docker setup experiment.rpz <dest>

# run an unpacked experiment with docker
reprounzip docker run experiment

# enter an interactive environment with all the software needed to run the experiment
reprounzip docker run experiment --cmdline bash
```

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
