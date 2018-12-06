# Vanilla Docker Packaging Example

The goal of this directory is to demonstrate good practices for archiving models using the Boltzmann Wealth Model
example from the 
[Mesa Python ABM framework](https://github.com/projectmesa/mesa/tree/master/examples/boltzmann_wealth_model_network)

# Software Requirements

You'll need `docker` installed for this example to work

# Instructions

Build the Docker image

```
docker build -t boltzmann-model-docker -f Dockerfile ../..
```

Then create a container from the image

```
docker run -it --rm -p 127.0.0.1:8521:8521 boltzmann-model-docker bash
```

Run the model inside in docker container

```
mesa runserver boltzmann
```
