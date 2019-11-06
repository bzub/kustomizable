# kubeless

[kubeless](https://kubeless.io/) is a Kubernetes-native serverless framework.

## Bases and Overlays

- [base](base)
- [crds](crds)
- [cluster-rbac](cluster-rbac)

## Quick Start

For multi-tenancy support kubeless is deployed in two parts:
1. Cluster-scoped CRDs/RBAC resources
1. Namespace-scoped resources (controller deployment, etc)

The first part must be created by a cluster admin. The second part by a
namespace admin.

The example below assumes a namespace of `example` is created where the
kubeless controller will actually run.

### Part 1 - Cluster Admin

The following kustomization deploys cluster-scoped resources and adds the
example namespace's service account to a ClusterRoleBinding.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/bzub/kustomizable/kubeless/crds
  - github.com/bzub/kustomizable/kubeless/cluster-rbac

patches:
  # Add serviceaccounts here to read kubeless CRDs.
  - target:
      group: rbac.authorization.k8s.io
      version: v1beta1
      kind: ClusterRoleBinding
      name: kubeless-controller-read-clusterrolebinding
    patch: |-
      - op: remove
        path: /subjects/0
      - op: add
        path: /subjects/-
        value:
          kind: ServiceAccount
          name: kubeless-controller-sa
          namespace: example
```

### Part 2 - Namespace Admin

The following kustomization deploys the kubeless controller to the `example`
namespace.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/bzub/kustomizable/kubeless/base

namespace: example

configMapGenerator:
  # Configure kubeless to watch one namespace.
  - name: kubeless-config
    behavior: merge
    literals:
      - functions-namespace=example
```

Now you can use the kubeless CLI with argument `-n example`.
