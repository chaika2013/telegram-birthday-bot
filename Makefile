# output docker image
DOCKER_IMAGE=chaika/telegram-birthday-reminder-bot
DOCKER_TAG=dev

# builder params
BUILDER_IMAGE=rust:1.81
DISTROLESS_IMAGE=gcr.io/distroless/cc-debian12

# build arguments for docker build
DOCKER_BUILD_ARGS=--build-arg BUILDER_IMAGE=$(BUILDER_IMAGE) \
				  --build-arg DISTROLESS_IMAGE=$(DISTROLESS_IMAGE)

# HELP =================================================================================================================
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## show help message
	@printf "\033[32m\xE2\x9c\x93 usage: make [target]\n\n\033[0m"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker-build: ## build in docker
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_ARGS) --target build .
.PHONY: docker-build

docker-image: ## build result docker image
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_ARGS) -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
.PHONY: docker-image

docker-push: ## push docker image
	DOCKER_BUILDKIT=1 docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
.PHONY: docker-image
