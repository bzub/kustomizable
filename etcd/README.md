# etcd

[etcd](https://etcd.io/) is a distributed reliable key-value store for the most
critical data of a distributed system.

## Bases and Overlays

- [base](base)
- [overlays/ha-cluster](overlays/ha-cluster)

## Jobs

- [tls-bootstrap](tls-bootstrap)

## Quick Start

```sh
# Create a namespace
kubectl create namespace etcd-example

# Build and create the tls-bootstrap job resources
kustomize build github.com/bzub/kustomizable/etcd/tls-bootstrap | \
  kubectl -n etcd-example create -f -

# Build and create the etcd resources
kustomize build github.com/bzub/kustomizable/etcd/base | \
  kubectl -n etcd-example create -f -
```
