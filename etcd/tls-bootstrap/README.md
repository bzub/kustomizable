# In-cluster etcd TLS bootstrap

`etcd/tls-bootstrap` creates TLS resources for etcd via Kubernetes Job and
stores them in a Secret. The examples below show a few ways to use those
resources.

## Method 1 - Cluster-only secrets

This method deploys `etcd/base` and `etcd/tls-bootstrap` in parallel. The etcd
pod(s) start after the tls-bootstrap job creates the secret they need.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - "github.com/bzub/kustomizable/etcd/base"
  - "github.com/bzub/kustomizable/etcd/tls-bootstrap"
```

## Method 2 - Fetch and use secrets locally

Using `tools/fetch-secret.sh` we can fetch the TLS resources locally to be
managed by kustomize or kubectl.

### Step 1 - Deploy `etcd/tls-bootstrap` standalone

```sh
kustomize build "github.com/bzub/kustomizable/etcd/tls-bootstrap" \
    kubectl -n etcd-example create -f -
```

### Step 2 - Download the TLS resources to a directory of files

```sh
SECRET_DIR=./secrets/pki/etcd tools/fetch-secret.sh -n etcd-example etcd-certs
```

### Step 3 - Reference the files in an etcd-based kustomization

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - "github.com/bzub/kustomizable/etcd/base"

namespace: etcd-example

secretGenerator:
  - name: etcd-certs
    files:
      - secrets/pki/etcd/ca.crt
      - secrets/pki/etcd/ca.key
      - secrets/pki/etcd/client.crt
      - secrets/pki/etcd/client.key
      - secrets/pki/etcd/peer.crt
      - secrets/pki/etcd/peer.key
      - secrets/pki/etcd/server.crt
      - secrets/pki/etcd/server.key
```
