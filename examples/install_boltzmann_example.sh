#!/usr/bin/env bash

curl -LO https://github.com/projectmesa/mesa/archive/v0.8.5.tar.gz
tar -xzf v0.8.5.tar.gz
mv mesa-0.8.5 mesa
mv mesa/examples/boltzmann_wealth_model_network boltzmann
rm -rf mesa
rm v0.8.5.tar.gz
