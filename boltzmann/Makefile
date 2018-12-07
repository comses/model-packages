CONFIG_BASE_PATH=config

DOCKER_IMAGE_NAME=boltzmann-docker
REPROZIP_BUILDER_IMAGE_NAME=boltzmann-builder-reprozip
REPROZIP_IMAGE_NAME=boltzmann-reprozip
NIX_IMAGE_NAME=boltzmann-nix:latest

DOCKER_RUN_OPTS=-it --rm -v ${PWD}/results:/app/data -p 127.0.0.1:8521:8521

RUN_HEADLESS=-m boltzmann_wealth_model_network.headless_run

.PHONY: init-cache images nix-image docker-image reprozip-image \
	docker-runserver docker-headless \
	nix-runserver nix-headless \
	reprozip-runserver reprozip-headless

cache=.cache
${cache}:
	mkdir ${cache}

#
# Build Image Rules
#

nix_image=.cache/nix_image
${nix_image} : ${CONFIG_BASE_PATH}/nix/buildImage.nix ${cache}
	cd ${CONFIG_BASE_PATH}/nix \
	  && nix build -f buildImage.nix \
	  && docker load < result
	touch ${nix_image}

docker_image=.cache/docker-image
${docker_image}: ${CONFIG_BASE_PATH}/docker/Dockerfile ${cache}
	cd ${CONFIG_BASE_PATH}/docker \
	  && docker build -t ${DOCKER_IMAGE_NAME} -f Dockerfile ../..
	touch ${docker_image}

reprozip_builder_image=.cache/reprozip-builder-image
${reprozip_builder_image}: ${CONFIG_BASE_PATH}/reprozip/Dockerfile ${cache}
	cd ${CONFIG_BASE_PATH}/reprozip \
	  && docker build -t ${REPROZIP_BUILDER_IMAGE_NAME} -f Dockerfile ../..
	touch .cache/reprozip-builder-image

reprozip_experiment=results/experiment.rpz
${reprozip_experiment}: reprozip-builder-image
	docker run ${DOCKER_RUN_OPTS} ${REPROZIP_BUILDER_IMAGE_NAME} bash -c "reprozip trace python3 -m boltzmann_wealth_model_network.headless_run; reprozip pack && mv experiment.rpz ../data/"

images: nix-image docker-image reprozip-builder-image

#
# Run Container Rules
#

docker-runserver: ${docker_image}
	docker run ${DOCKER_RUN_OPTS} ${DOCKER_IMAGE_NAME}

docker-headless: ${docker_image}
	docker run ${DOCKER_RUN_OPTS} ${DOCKER_IMAGE_NAME} python3 ${RUN_HEADLESS}

nix-runserver: ${nix_image}
	docker run ${DOCKER_RUN_OPTS} ${NIX_IMAGE_NAME}

nix-headless: ${nix_image}
	docker run ${DOCKER_RUN_OPTS} ${NIX_IMAGE_NAME} python3 ${RUN_HEADLESS}

reprozip-headless: ${reprozip_builder_image}
	docker run ${DOCKER_RUN_OPTS} -v /var/run/docker.sock:/var/run/docker.sock ${REPROZIP_IMAGE_NAME} bash # -c "reprounzip docker run ../data/experiment.rpz" 

#
# Util
#

clean:
	rm -r .cache
	rm results/experiment.rpz
