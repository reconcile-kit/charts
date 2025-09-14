HELM_IMAGE = alpine/helm:3.16.2
CT_IMAGE = quay.io/helmpack/chart-testing:v3.11.0
HELM?=helm-docker
CONTAINER_TOOL ?= docker
CONTAINER_USER_OPTION = --user $(shell id -u):$(shell id -g)
REPODIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

helm-docker:
	mkdir -p .helm/cache
	$(CONTAINER_TOOL) run --rm --name helm-exec  \
		$(CONTAINER_USER_OPTION) \
		--volume "$(REPODIR):/helm-charts" \
		--volume "$(REPODIR)/.github/ci/helm-repos.yaml:/helm-charts/.helm/config/repositories.yaml" \
		-w /helm-charts \
		-e HELM_CACHE_HOME=/helm-charts/.helm/cache \
		-e HELM_CONFIG_HOME=/helm-charts/.helm/config \
		-e HELM_DATA_HOME=/helm-charts/.helm/data \
		$(HELM_IMAGE) \
		$(CMD)

helm-repo-update:
	CMD="repo update" $(MAKE) $(HELM)