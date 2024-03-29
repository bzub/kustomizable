# Bootstrap Jobs

Bootstrap jobs in this repository only deploy a Kubernetes Job, which usually
generates resources that can then be used in a few ways.

## [etcd/tls-bootstrap](/etcd/tls-bootstrap) example

### Method 1 - Cluster-only secrets

This method deploys [etcd/base](/etcd/base) and etcd/tls-bootstrap in parallel.
The etcd pod(s) start after the tls-bootstrap job creates the secret they need.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - "github.com/bzub/kustomizable/etcd/base"
  - "github.com/bzub/kustomizable/etcd/tls-bootstrap"
```

### Method 2 - Fetch and use secrets locally

This method involves fetching the TLS resources locally to be managed by
kustomize or kubectl.

#### Step 1 - Deploy etcd/tls-bootstrap standalone

```sh
kubectl create namespace example

kustomize build "github.com/bzub/kustomizable/etcd/tls-bootstrap" | \
    kubectl -n example create -f -
```

#### Step 2 - Download the TLS resources to a directory of files

Using [fetch-secret.sh](/tools/fetch-secret.sh) from this repo:

```sh
SECRET_DIR=./secrets/pki/etcd fetch-secret.sh -n example etcd-certs
```

#### Step 3 - Reference the files in an etcd-based kustomization

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
