# Building in Nix

## Instructions

[Install nix](https://nixos.org/nix/) directly on your machine (will only work on Linux)

Then build the docker image

```
nix build -f buildImage.nix
```

Load the image into docker

```
docker load < result
```

Create a container from the image

```
docker run -it --rm -p 127.0.0.1:8521:8521 $IMAGE_NAME
```

Run the model (from the previous command you should be on a terminal inside the docker container

```
mesa runserver
```

Open your web browser at 127.0.0.1:8521 to try out the model.
