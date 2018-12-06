FROM docker:18.06

RUN apk add bash build-base freetype-dev gcc gfortran git libpng-dev openblas-dev python3 python3-dev sqlite-dev subversion \
  && pip3 install reprozip reprounzip reprounzip-docker
WORKDIR /app

COPY src src/
RUN pip3 install -r src/requirements.txt

CMD ["bash"]
