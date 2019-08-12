# helm-charts

[![Build Status][travis-image]][travis-url]

[travis-image]: https://travis-ci.org/edgelevel/helm-charts.svg?branch=master
[travis-url]: https://travis-ci.org/edgelevel/helm-charts

```bash
# add helm repository
helm repo add edgelevel-public https://edgelevel.github.io/helm-charts
```

| Name | Version | Description |
| ---- |:-------:| ----------- |
| argocd | 1.1.2-0 | [Argo CD](https://argoproj.github.io/argo-cd/) is a declarative, GitOps continuous delivery tool for Kubernetes |

### Development

```bash
# update argocd chart
make update-argocd

# publish chart from local machine
make publish chart=argocd
```
