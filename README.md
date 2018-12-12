# Comparison of reproducible package formats for an example Mesa agent based model

This repository explores some existing solutions for packaging computational models. There are example model packages for [Docker](https://docs.docker.com/install/), [Nix](https://nixos.org/nix/) and [Reprozip](https://www.reprozip.org/) all using the same agent based model example from the [Mesa ABM Framework](https://github.com/projectmesa/mesa) - the Boltzmann Wealth Model Network model.

## Contents

```
.
├── boltzmann
│   ├── config
│   │   ├── docker     #1
│   │   ├── nix        #2
│   │   ├── reprozip   #3
│   ├── Makefile       #4
│   ├── README.md
│   ├── results
│   └── src
│       ├── boltzmann_wealth_model_network
│       ├── README.md
│       ├── requirements.txt
│       └── run.py
└── README.md
```

1. packaging example with Docker
2. packaging example with Nix
3. packaging example with Reprozip
4. Makefile to build and run all examples. Two run setups are available: a Mesa runserver that provides interactive access by visiting `localhost:8521` and a headless run that generates data in `results/`. To run one of these options you can run `make docker-runserver`, `make docker-headless`, `make nix-runserver`, `make nix-headless` or `make reprozip-headless` from the command line. 

Detailed instructions are available in each example package folder.

## Contributing

A `reprozip` example tracing an interactive `runserver` session was too difficult to complete (help or a PR for that would be welcome!).

If you have any improvements or suggestions please feel free to submit a PR or create an issue. Thanks!

## Experience Creating the Examples

### Docker

Dockerizing the boltzmann model was straight forward. I created a Dockerfile with all the necessary debian packages installed to install and run the mesa model. Then, using the `python3-pip` package that I just installed the python library dependendencies can be installed. The working directory is set to `/app/src` and th default command is set to `mesa runserver` so that the boltzmann example will start automatically on a newly created container built off of this image.

### Guix

I gave up. The process of creating a package seemed very similar to Nix but with fewer packages available in the repository it would have required creating more than one Python package to create a running example.

### Nix

I found Nix more involved than Docker. In order to work with a stable set of packages I had to first [pin the repository nixpkgs version](https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs). Then, since Mesa wasn't part of nixpkgs I had create a Mesa nix package. Creating a Mesa package required some work because of dependency conflicts between `jupyter`, `tornado` and `Mesa`. `Mesa` depended on `jupyter` and a version of `tornado` before 5. The `jupyter` package in the version of nixpkgs used depended on  `tornado` 5. This dependency mismatch forced me to override the `tornado` package to so that `jupyter` built using `tornado` 4. Creating the `buildImage.nix` and `shell.nix` files were about the same difficulty as creating the Dockerfile.

### ReproZip

Reprozip was fairly easy to install and run in a Docker container. What was more challenging was running the experiment again and inspecting the data created. `reprozip docker run` exits the container as soon as the run is done so in order to inspect the outputs created you must set the appropriate flags to mount a shared volume so that a model run's output data is placed somewhere accessible.

### Spack

I have not tried to create an example yet although it looks similar to Nix and Guix.

### Thoughts

The ability to use the dependency management tooling built for the Linux distribution and programming language reduces the amount of work required to create an archive of your computational model since the programming language's package manager has more packages defined than whole system package managers like Nix and Guix.

The reprozip packages have some system dependencies like sqlite but is otherwise straight forward to install. Experiment archives are small but also don't have important base packages without manually editing the Dockerfile or explicitly adding paths to libraries and executables you want to include in the image for interactive use (such as `coreutils` and `bash`).

Docker was the simplest of the options to setup for the Boltzmann example. It worked with the existing requirements.txt file (Nix has third party support with `pypi2nix` but still requires creating any packages that aren't already in nixpkgs or third party overlays). It also includes a recipe to rebuild the execution environment (the Dockerfile). Reprozip required knowledge of Docker in order to execute the model interactively (mounting volumes to access experiment run data) so some Docker knowledge ends up being necessary anyway.
