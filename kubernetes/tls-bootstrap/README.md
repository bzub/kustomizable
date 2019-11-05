## Notes

```sh
kubectl create ns example
kustomize build ../kubernetes/tls-bootstrap/overlays/with-etcd-tls-bootstrap |\
	kubectl -n example apply -f -
SECRET_DIR=./resources/secrets/kubeconfigs \
	../tools/fetch-secret.sh -n example kubeconfigs
SECRET_DIR=./resources/secrets/pki/k8s \
	../tools/fetch-secret.sh -n example k8s-certs
SECRET_DIR=./resources/secrets/pki/etcd \
	../tools/fetch-secret.sh -n example etcd-certs
```
