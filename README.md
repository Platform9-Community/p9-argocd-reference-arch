# ArgoCD Reference Architecture

## Usage

## Design Goals

1. Bootstrap ArgoCD, cluster infrastructure components and applications from one repo
1. One repo for all environments (dev, staging, prod, qa etc) even at scale
1. Minimze duplication through kustomizations
1. Repo artifacts can reference external versioned helm charts and manifests, for example micro services from other git repos
