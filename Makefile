.DEFAULT_GOAL := all

HELM := $(shell command -v helm 2> /dev/null)

.PHONY: requirements
requirements:
ifndef HELM
	$(error "helm" not found)
endif

# publish to https://edgelevel.github.io/helm-charts
.PHONY: publish
publish: requirements
	./scripts/publish.sh ${chart}

.PHONY: all
all: requirements
