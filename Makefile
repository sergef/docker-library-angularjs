DOCKER_REGISTRY=
DOCKER_IMAGE_TAG=docker-library-angularjs

build:
	sed 's|%DOCKER_REGISTRY%|$(DOCKER_REGISTRY)|g' Dockerfile.tpl > Dockerfile.tmp
	docker build \
		-f Dockerfile.tmp \
		--build-arg HTTP_PROXY=$(HTTP_PROXY) \
		-t $(DOCKER_REGISTRY)$(DOCKER_IMAGE_TAG) .

install-gc:
	gcloud docker push $(DOCKER_REGISTRY)$(DOCKER_IMAGE_TAG)
