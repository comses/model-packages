# Vanilla Docker Packaging Example

The goal of this directory is to demonstrate good practices for archiving models using the Boltzmann Wealth Model
example from the 
[Mesa Python ABM framework](https://github.com/projectmesa/mesa/tree/master/examples/boltzmann_wealth_model_network)

## Software Requirements

You'll need `docker` installed for this example to work

## Instructions

Use the `Makefile` at the root of the example. Run `make docker-runserver` for
a interactive example (open your browser at localhost:8521) or 
`make docker-headless` to run model non interactively.

## Contents

- `Dockerfile` instructions to build a Docker image to house the model
