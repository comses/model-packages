CONFIG_BASE_PATH=config

DOCKER_IMAGE_NAME=boltzmann-docker
REPROZIP_BUILDER_IMAGE_NAME=boltzmann-builder-reprozip
REPROUNZIP_RUNNER_IMAGE_NAME=boltzmann-runner-reprounzip
NIX_IMAGE_NAME=boltzmann-nix:latest

DOCKER_RUN_OPTS=-it --rm -v ${PWD}/results:/app/data -p 127.0.0.1:8521:8521

RUN_HEADLESS=-m boltzmann_wealth_model_network.headless_run

.PHONY: images \
	docker-runserver docker-headless \
	nix-runserver nix-headless \
	reprozip-headless

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

docker_image=.cache/docker_image
${docker_image}: ${CONFIG_BASE_PATH}/docker/Dockerfile ${cache}
	cd ${CONFIG_BASE_PATH}/docker \
	  && docker build -t ${DOCKER_IMAGE_NAME} -f Dockerfile ../..
	touch ${docker_image}

reprozip_builder_image=.cache/reprozip_builder_image
${reprozip_builder_image}: ${CONFIG_BASE_PATH}/reprozip/Dockerfile.reprozip ${cache}
	cd ${CONFIG_BASE_PATH}/reprozip \
	  && docker build -t ${REPROZIP_BUILDER_IMAGE_NAME} -f Dockerfile.reprozip ../..
	touch ${reprozip_builder_image}

reprounzip_runner_image=.cache/reprounzip_runner_image
${reprounzip_runner_image}: ${CONFIG_BASE_PATH}/reprozip/Dockerfile.reprounzip ${cache}
	cd ${CONFIG_BASE_PATH}/reprozip \
	  && docker build -t ${REPROUNZIP_RUNNER_IMAGE_NAME} -f Dockerfile.reprounzip .
	touch ${reprounzip_runner_image}

reprozip_experiment=results/experiment.rpz
${reprozip_experiment}: ${reprozip_builder_image}
	docker run ${DOCKER_RUN_OPTS} --cap-add=SYS_PTRACE ${REPROZIP_BUILDER_IMAGE_NAME}

images: ${nix_image} ${docker_image} ${reprozip_builder_image} ${reprounzip_runner_image}

#
# Run Container Rules
#

docker-runserver: ${docker_image}
	docker run ${DOCKER_RUN_OPTS} ${DOCKER_IMAGE_NAME}

docker-headless: ${docker_image}
	docker run ${DOCKER_RUN_OPTS} ${DOCKER_IMAGE_NAME} python3 ${RUN_HEADLESS} docker

nix-runserver: ${nix_image}
	docker run ${DOCKER_RUN_OPTS} ${NIX_IMAGE_NAME}

nix-headless: ${nix_image}
	docker run ${DOCKER_RUN_OPTS} ${NIX_IMAGE_NAME} python3 ${RUN_HEADLESS} nix

reprozip-headless: ${reprozip_experiment} ${reprounzip_runner_image}
	@echo "Follow instructions at https://docs.reprozip.org/en/1.0.x/unpacking.html to run or inspect an experiment"
	docker run -it --rm -v ${PWD}/results:/app/experiments -v /var/run/docker.sock:/var/run/docker.sock --cap-add=SYS_PTRACE ${REPROUNZIP_RUNNER_IMAGE_NAME} bash 

#
# Util
#

clean:
	rm -rf .cache
	sudo rm -rf results/*
