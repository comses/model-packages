# Building in Nix

Nix is a package manager that works on Linux and Mac OS X that supports multiple
versions of a package and creating isolated environments for developing
software.

## Software Requirements

[Install nix](https://nixos.org/nix/) directly on your machine (will only work on Linux)

## Instructions

Use the `Makefile` at the root of this example. Run `make nix-runserver` to run
the model interactively (open a web browser at localhost:8521) or
`nix-headless` the run the model without interaction

## Contents

- `buildImage.nix` - a recipe to build a Docker image of the model
- `shell.nix` - an environment to develop work on the model in. In this
  directory you can type `nix-shell` into the CLI and you will now be in
  a shell that contains all your dependencies
- `mesa.nix` - a recipe to build the `Mesa` ABM python package in Nix
- `pinned.nix` - a declaration of what snapshot of the Nix package
  repository to use to the Docker image, Mesa package and shell environment
  from
