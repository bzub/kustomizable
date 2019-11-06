# In-cluster etcd TLS generation

`etcd/tls-bootstrap` creates TLS resources for etcd via Kubernetes Job and
stores them in a Secret.

Configuration options can be found in the
[kustomization.yaml](kustomization.yaml).

## Secrets

### `etcd-certs` (default name)

Keys:
- ca.crt
- ca.key
- client.crt
- client.key
- peer.crt
- peer.key
- server.crt
- server.key

## Quick Start

```sh
kubectl create namespace example

kustomize build github.com/bzub/kustomizable/etcd/tls-bootstrap | \
  kubectl -n example create -f -
```
