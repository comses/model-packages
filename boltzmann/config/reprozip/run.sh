#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

reprozip trace python3 -m boltzmann_wealth_model_network.headless_run reprozip1
reprozip trace python3 -m boltzmann_wealth_model_network.headless_run reprozip2
cat additional_patterns.yml >> .reprozip-trace/config.yml
reprozip pack
mv experiment.rpz ../data/
