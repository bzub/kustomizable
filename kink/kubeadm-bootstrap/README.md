# In-cluster node TLS bootstrap + kubeconfig generation

`kink/kubeadm-bootstrap` sets the cluster up for node TLS bootstrapping, and
generates a bootstrap token + bootstrap kubeconfig.

For more information see:
- [TLS bootstrapping](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/#kubelet-configuration)
- [kubeadm init phase bootstrap-token](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init-phase/#cmd-phase-bootstrap-token)

Configuration options can be found in the
[kustomization.yaml](kustomization.yaml).

## Secrets

### `kubelet-bootstrap`

Keys:
- kubelet-bootstrap.conf

## Quick Start

Using [fetch-secret.sh](/tools/fetch-secret.sh) from this repo:

```sh
kustomize build github.com/bzub/kustomizable/kink/kubeadm-bootstrap | \
  kubectl -n kube-system create -f -

fetch-secret.sh -n kube-system kubelet-bootstrap
```

At this point you will want to modify the `server: ` part of
`kubelet-bootstrap.conf` to something that points to your cluster apiserver(s).
This endpoint is configurable via
[ConfigMap/kustomization](kustomization.yaml), too.

Then, copy `kubelet-bootstrap.conf` to a machine you want to add to the cluster
and run:

```sh
kubelet --bootstrap-kubeconfig="/etc/kubernetes/kubelet-bootstrap.conf" \
	--kubeconfig="/etc/kubernetes/kubelet.conf" \
	--network-plugin=cni
```

The kubelet will aquire long-term certs and create a kubeconfig at
`/etc/kubernetes/kubelet.conf`. The bootstrap token will be deleted after 24
hours.
