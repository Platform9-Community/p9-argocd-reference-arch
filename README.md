# ArgoCD Reference Methodology

This repo implements an opinionated architecture implemenation of gitops with ArgoCD.

The definitions for the ArgoCD installation are maintained here as well as all of the kubernetes cluster infrastructure components and applications.

## Design Goals

1. Bootstrap ArgoCD, cluster infrastructure components and applications from one repo
1. One repo for all environments (dev, staging, prod, qa etc) even at scale
1. Minimze duplication through kustomizations
1. Repo artifacts can reference external versioned helm charts and manifests, for example micro services from other git repos

## Usage

This repo is used in conjuction with [site deployer](https://github.com/Platform9-Community/site-deployer/tree/main).
Any `kind: Site` objects in the `sites/` directory are provisioned via ansible.

### Use Case 1 (many clusters sharing the same manifests)

Suppose for example that you have many remote sites. At each site location you have one or more Kubernetes clusters, each a cookie cutter copy of a master template.
In this scenario, you can run ArgoCD on every cluster, pointed a single directory location in a repo. When you make a change to any of the manifests in the repo,
all the sites reconcile themselves with the change.

An example of this is the `clusters/osfa` (One Size Fits All) folder.
To add a new replica Site for instance `sdf-qa1`, you can do the following:

```
just re-use osfa sdf-qa1
```

This will create a new `kind: Site` object in the `sites/` directory for `sdf-qa1`, pointed to the `clusters/osfa` directory.

### Use Case 2 (each cluster can be unique but with minimal manifest duplication)

In another scenario, you may have multiple kubernetes clusters with varying degrees of manifest overlap. There might be a lot of differences, or very few.
With Kustomize you can create manifest overlays that represent those differences. All of the manifest unions need not be duplicated, only what is distinct.

You could begin with an existing cluster definition as a starting point.

```
just clone atl-dev lax-dev1
```
