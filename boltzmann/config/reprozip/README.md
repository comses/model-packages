# Overview

Reprozip is a software package for creating, bundling and executing experiments.

`reprozip ` is a command-line tool for tracing experiments. It is run on the command line and uses the [PTRACE](http://www.man7.org/linux/man-pages/man2/ptrace.2.html#NAME) system call to identity what the dependencies of an _experiment_ (in this case a run of the Mesa Boltzmann wealth network model). _Experiments_ contain all the files necessary to run on another another computer. This includes system and library dependencies, source code as well as input and output data.

`reprounzip` is a command-line tool for unpacking experiments and inspecting experiments made by `reprozip`. There are a number of different unpackers for `reprounzip`. This example uses and has been tested with the `docker` unpacker but the unpackers may also work.

## Software Requirements

All Operating Systems:

- docker

On Mac OS X and Windows:

- reprounzip
- reprounzip-docker

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
reprounzip docker run experiment --cmdline /busybox ash
```

## Instructions

Use the `Makefile` in the root of the project. Run `make reprozip-headless` to generate an `experiment.rpz` file in the results folder. 
You'll want to unpack the experiment first:

```
reprounzip docker setup experiments/experiment.rpz <output-directory>
# where <output-directory> is the name of the directory where you want to unpack the
# experiment. The experiments directory is shared so if you want to see the results
# on your host machine outside of the Docker container you can use something like 
# experiments/unpack-output
```

Now you can rerun the experiment or export any results.

Below are some examples of using 

### Using Docker Volume Mounts to Save Data

```
reprounzip docker run <experiment-directory> --cmdline /busybox ash
```

To start an interactive session and then run one of the previous command line invocations like

```
python -m boltzmann_wealth_model_network.headless_run test
```

to run the model to generate some new outputs. Model results will be available for inspection in the `data/` folder. You'll also probably want the analysis data to be available outside the container. In order to do that you'll need to use `docker cp <container_name>:<source path> <destination path>` to get the data outside the container. It is also possible to write to a shared directory. To do that you can run the experiment by passing options to `docker` with the `--docker-opt` flag. The following will mount the `results` folder of the current directory to `/app/data` location in the container (which is where the script will write its output files to).

```
reprounzip docker run <experiment-directory> --docker-option=-v --docker-option=$PWD/results:/app/data
```

### Using Docker Images Created by Previous Docker Runs

To run a new experiment without any manual intervention you could run

```bash
reprounzip docker run <experiment-directory> --cmdline python3 -m boltzmann_wealth_model_network.headless_run test
```

Which will hopefully print out something like

```
*** Command finished, status: 0
sha256:ed53df84ffd072addf62e70c63687aa99a695a8797f3b8ea6eae43a21693d8fa
reprounzip_run_i4snt4qodf
```

This will create a new image with a sha256 noted as above. Find the docker image with that sha by running `docker images`. Then run that image using the found ID.

```bash
docker run -it <image-name> bash
```

Then look at the data created from a previous run 

```bash
cd /app/data
ls
```

In a different terminal (with the container still running) it is possible to copy the data out.

```bash
docker cp <container-name>:/app/data/test_agents.csv .
```

For output file names identified by the experiment archives such as `reprozip1_agents.csv` you are able to download the output data much more easily with

```bash
reprounzip docker download <output-file-name>
```

*Note*: ReproUnzip 1.1 will support downloading files at arbitrary paths in the container which will make that convoluted `docker cp` process above unnecessary

#### Resources

- [reprozip unpacking](https://docs.reprozip.org/en/1.0.x/unpacking.html) docs


## Contents

- `Dockerfile` - instructions for building an image that has `reprozip` and `reprounzip` in it. Used to build and run reprozips archives.
