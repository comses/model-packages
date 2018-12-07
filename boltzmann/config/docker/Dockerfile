FROM python:3.7-alpine

RUN apk add bash build-base freetype-dev gcc gfortran git libpng-dev openblas-dev python3 python3-dev subversion

WORKDIR /app

COPY src src/
RUN pip3 install -r src/requirements.txt
RUN apk add bash sqlite-dev && pip3 install reprozip reprounzip reprounzip-docker

WORKDIR /app/src

CMD ["mesa", "runserver"]
