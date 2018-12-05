FROM nixos/nix:2.1.3

WORKDIR /app

RUN nix-env -i curl gnutar \
  && curl -LO https://github.com/projectmesa/mesa/archive/v0.8.5.tar.gz \
  && tar -xzf v0.8.5.tar.gz \
  && mv mesa-0.8.5 mesa \
  && rm v0.8.5.tar.gz
COPY mesa.nix shell.nix buildImage.nix ./
