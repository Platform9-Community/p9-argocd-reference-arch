# ArgoCD Reference Architecture

This repo implements an opinionated implemenation of gitops with ArgoCD.

## Design Goals

1. Bootstrap ArgoCD, cluster infrastructure components and applications from one repo
1. One repo for all environments (dev, staging, prod, qa etc) even at scale
1. Minimze duplication through kustomizations
1. Repo artifacts can reference external versioned helm charts and manifests, for example micro services from other git repos

## Usage

### Use Case 1 (many clusters sharing the same manifests)

```
just re-use osfa sdf-qa1
```

### Use Case 2 (each cluster can be unique but with minimal manifest duplication)

```
just clone sdf-prod1 lax-prod1
```
