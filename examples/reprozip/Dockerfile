FROM docker:18.06

RUN apk add bash build-base curl freetype-dev gcc gfortran git libpng-dev openblas-dev python3 python3-dev sqlite-dev subversion \
  && pip3 install reprozip reprounzip reprounzip-docker
WORKDIR /app

COPY install_boltzmann_example.sh .
RUN ./install_boltzmann_example.sh
RUN pip3 install -r boltzmann/requirements.txt

COPY headless_run.py boltzmann/boltzmann_wealth_model_network
