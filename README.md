# Packaging a Mesa Geo Model using different packaging formats

This repository explores some of the existing solutions for packaging models.
There are example model packages for Docker, Nix and Reprozip all using the
same [mesa](https://github.com/projectmesa/mesa) model - Boltzmann Wealth Model
Network.

## Contents

```
.
├── examples
│   ├── docker           # 1
│   ├── headless_run.py  # 4
│   ├── nix              # 2
│   └── reprozip         # 3
└── README.md
```

1. packaging example with Docker
2. packaging example with Nix
3. packaging example with Reprozip
4. script included in all packages that adds instrumentation to the model so 
   that the model's environment and agent state is saved as CSVs at the end of
   the model run. Model packaging is useful collaboration and archival.

Detailed packaging instructions are available in each example package folder.
