# In-cluster kubernetes TLS generation

`kubernetes/tls-bootstrap` creates TLS resources for kubernetes via Kubernetes
Job and stores them in a Secret.

Configuration options can be found in the
[kustomization.yaml](kustomization.yaml).

## Secrets

### `kubeconfigs`

Keys:
- admin.conf
- controller-manager.conf
- kubelet.conf
- scheduler.conf

### `k8s-certs`

Keys:
- apiserver-etcd-client.crt
- apiserver-etcd-client.key
- apiserver-kubelet-client.crt
- apiserver-kubelet-client.key
- apiserver.crt
- apiserver.key
- ca.crt
- ca.key
- front-proxy-ca.crt
- front-proxy-ca.key
- front-proxy-client.crt
- front-proxy-client.key
- sa.key
- sa.pub

## Quick Start

```sh
kubectl create namespace example

kustomize build ../kubernetes/tls-bootstrap/overlays/with-etcd-tls-bootstrap |\
	kubectl -n example apply -f -
```
