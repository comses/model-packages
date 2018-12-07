# Packaging a Mesa Geo Model using different packaging formats

This repository explores some of the existing solutions for packaging models.
There are example model packages for Docker, Nix and Reprozip all using the
same [mesa](https://github.com/projectmesa/mesa) model - Boltzmann Wealth Model
Network.

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
4. Makefile to build and run all examples. Two run setups are available: the
  Mesa runserver and the headless run. To run one of these options from try
  `docker-runserver`, `docker-headless`, `nix-runserver`, `nix-headless` or
  `reprozip-headless` from the command line. A `reprozip` example of tracing
  a `runserver` session is not included.

Detailed packaging instructions are available in each example package folder.
