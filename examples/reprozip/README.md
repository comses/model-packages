# Instructions

Build the docker container that has `reprozip` and `reprounzip` installed

```
./run.sh build
```

Create and enter a container built on the previously created `reprozip` image

```
./run.sh run
```

Trace a interactive model run

```
reprozip trace python3 -m boltzmann_wealth_model_network.headless_run
```

This will start the Mesa model non interactively.

Reprozip should now have archived the dependencies for your run of the model.
To save the dependencies in an archive run

```
reprozip pack
```

This will create a file called `experiment.rpz` in the current directory.

Since this container has the docker socket mounted into the container we can
use `reprounzip docker` as well.

```
reprounzip docker experiment.rpz
```


