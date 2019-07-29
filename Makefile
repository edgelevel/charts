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

# https://gist.github.com/niqdev/fffc1b27f50cbc6436e264b8d48a1b62
.PHONY: update-argocd
update-argocd:
	./scripts/generate_argocd_templates_macos.sh

.PHONY: all
all: requirements
