# helm-charts

[![Build Status][travis-image]][travis-url]

[travis-image]: https://travis-ci.org/edgelevel/helm-charts.svg?branch=master
[travis-url]: https://travis-ci.org/edgelevel/helm-charts

```bash
# add helm repository
helm repo add edgelevel-public https://edgelevel.github.io/helm-charts
```

| Name | Version | ArgoCD Version | Description |
| ---- |:-------:| -------------- | ----------- |
| argocd | v1.1.0-rc2|   v1.1.0-rc2 | [Argo CD](https://argoproj.github.io/argo-cd/) is a declarative, GitOps continuous delivery tool for Kubernetes |

### Development

```bash
# publish chart from local machine
./publish.sh argocd
```
