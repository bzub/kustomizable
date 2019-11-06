# Kustomizable

A curated collection of components meant to be built/modified using
[kustomize](https://github.com/kubernetes-sigs/kustomize) and applied to
Kubernetes clusters.

## Project Principles

- Base kustomizations should:
  - Define a ConfigMap in the `kustomization.yaml` to configure the application.
  - Implement generic best-practices like:
    - {liveness,readiness} probes.
    - Prometheus scrape annotations.
  - Reference secrets by name, leaving their implementation to the user.
  - Be small, as in deployable to a default minikube cluster.
    - 1 replica where applicable.
  - Use emptyDir volumes where persistent storage is expected.
    - Storage is domain-specific and should be kustomized by the user.

- Overlay kustomizations should:
  - Represent the most common modifications of a base (highly-available replicas, etc)
  - Serve as examples for user overlays.

- [Bootstrap jobs](docs/bootstrap-jobs.md) should:
  - Performs a one-time task.
  - Generates resources that shouldn't be in version control (secrets).
  - Generates resources with names that base kustomizations refer to.
