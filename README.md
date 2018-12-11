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


