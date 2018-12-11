FROM phusion/baseimage:0.11

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  python3-pip \
  python3-setuptools \
  python3-wheel \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

COPY src src/
RUN pip3 install -r src/requirements.txt

WORKDIR /app/src

CMD ["mesa", "runserver"]
