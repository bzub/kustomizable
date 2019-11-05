# Kubernetes-in-kubernetes (kink)

Deploys a Kubernetes control-plane in an existing cluster using the
[etcd](../etcd) and [kubernetes](../kubernetes) kustomizations as bases.

## Bases and Overlays

- [base](base)
- [overlays/ha-cluster](overlays/ha-cluster)
- [overlays/with-tls-bootstrap](overlays/with-tls-bootstrap)

## Jobs

- [kubeadm-bootstrap](kubeadm-bootstrap)

## Quick Start

```sh
# Create a namespace
kubectl create namespace kink-example

# Build and create the resources
kustomize build github.com/bzub/kustomizable/kink/overlays/with-tls-bootstrap | \
  kubectl -n kink-example create -f -
```
