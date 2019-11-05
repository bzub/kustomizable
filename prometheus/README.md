# prometheus

[prometheus]() is a monitoring system and time series database.

## Bases and Overlays

- [base](base)

## Quick Start

```sh
# Create a namespace
kubectl create namespace prometheus-example

# Build and create the resources
kustomize build github.com/bzub/kustomizable/prometheus/base | \
  kubectl -n prometheus-example create -f -
```

## Implementation

The default scrape rules are found in the ConfigMaps defined in the base
[kustomization.yaml](base/kustomization.yaml). It uses Kubernetes service
discovery and annotations to find scrape targets.
