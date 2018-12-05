FROM docker:18.06

RUN apk add build-base freetype-dev gcc gfortran git libpng-dev openblas-dev python3 python3-dev subversion

WORKDIR /app

RUN git clone --depth 1 https://github.com/projectmesa/mesa.git \
  && pip3 install -r mesa/examples/boltzmann_wealth_model_network/requirements.txt
RUN apk add bash sqlite-dev && pip3 install reprozip reprounzip reprounzip-docker

WORKDIR /app/mesa/examples/boltzmann_wealth_model_network

COPY headless_run.py boltzmann_wealth_model_network/
COPY ./reprozip/interactive.sh .
