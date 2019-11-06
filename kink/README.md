# Kubernetes-in-kubernetes (kink)

Deploys a Kubernetes control-plane in an existing cluster using the
[etcd](../etcd) and [kubernetes](../kubernetes) components as bases.

## Bases and Overlays

- [base](base)
- [overlays/ha-cluster](overlays/ha-cluster)
- [overlays/with-tls-bootstrap](overlays/with-tls-bootstrap)

## Jobs

- [kubeadm-bootstrap](kubeadm-bootstrap)

## Quick Start

[fetch-secret.sh](/tools/fetch-secret.sh) can be found in this repo.

```sh
# Create a namespace.
kubectl create namespace example

# Build and create the resources.
kustomize build github.com/bzub/kustomizable/kink/overlays/with-tls-bootstrap | \
  kubectl -n example create -f -

# Use fetch-secrets.sh from this repo to download kubeconfigs.
tools/fetch-secret.sh -n example kubeconfigs

# Proxy kube-apiserver to your local machine.
kubectl -n example port-forward svc/kube-apiserver-svc 6443 &

# Communicate with the new cluster.
kubectl --kubeconfig secrets/admin.conf --server https://127.0.0.1:6443 get ns
```
