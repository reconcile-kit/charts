# Insight — Helm Chart

A production-ready Helm chart to deploy the open-source [**Insight**](https://github.com/reconcile-kit/insight) application on Kubernetes.

---

## Prerequisites

- Kubernetes cluster
- Helm 3.x installed
- (Optional) An Ingress controller if you enable ingress.

---

## Quick Start

### Add a helm chart repository

Add helm chart repository for your local helm environment:

```bash
helm repo add reconcile-kit https://reconcile-kit.github.io/charts/

helm repo update
```

### Installation

Start from the provided `values.yaml` and adjust as needed:

```bash
# for example, enable ingress
helm install insight reconcile-kit/insight \
  --namespace insight \
  --create-namespace \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host="insight.example.com"
```

> Tip: Set `image.tag` to a fixed version (defaults to the chart `appVersion` if empty).

If you prefer a custom values file:

```bash
helm install insight reconcile-kit/insight -n insight --create-namespace -f values.yaml
```

---

## Upgrade

```bash
helm upgrade insight reconcile-kit/insight -n insight -f values.yaml
```


---

## Uninstall

```bash
helm uninstall insight -n insight
```

This removes all Kubernetes objects created by the release (PVCs you created independently are not affected).

---

## Configuration Reference

All configurable parameters and their defaults are listed below (from `values.yaml`).

### Core

| Key | Type | Default | Description |
|---|---|---:|---|
| `replicaCount` | int | `1` | Number of pod replicas. |
| `image.repository` | string | `dhnikolas/insight` | Container image repository. |
| `image.pullPolicy` | string | `IfNotPresent` | Image pull policy. |
| `image.tag` | string | `""` | Image tag (falls back to chart `appVersion` if empty). |
| `imagePullSecrets` | list | `[]` | Secrets for pulling from private registries. |
| `nameOverride` | string | `""` | Override chart name. |
| `fullnameOverride` | string | `""` | Override full release name. |

### Service Account

| Key | Type | Default | Description |
|---|---|---:|---|
| `serviceAccount.create` | bool | `false` | Create a ServiceAccount. |
| `serviceAccount.automount` | bool | `true` | Automount API credentials into Pods. |
| `serviceAccount.annotations` | map | `{}` | Annotations to add to the ServiceAccount. |
| `serviceAccount.name` | string | `""` | Existing ServiceAccount name to use. |

### Pod Settings

| Key | Type | Default | Description |
|---|---|---:|---|
| `podAnnotations` | map | `{}` | Additional Pod annotations. |
| `podLabels` | map | `{}` | Additional Pod labels. |
| `podSecurityContext` | map | `{}` | Pod-level security context. |
| `securityContext` | map | `{}` | Container-level security context. |

### Service

| Key | Type | Default | Description |
|---|---|---:|---|
| `service.type` | string | `ClusterIP` | Service type. |
| `service.port` | int | `80` | Service port. |

### Ingress

| Key | Type | Default | Description |
|---|---|---:|---|
| `ingress.enabled` | bool | `false` | Enable Ingress. |
| `ingress.className` | string | `""` | IngressClass name. |
| `ingress.annotations` | map | `{}` | Ingress annotations. |
| `ingress.hosts[0].host` | string | `chart-example.local` | Example hostname. |
| `ingress.hosts[0].paths[0].path` | string | `/` | Path for the host. |
| `ingress.hosts[0].paths[0].pathType` | string | `ImplementationSpecific` | Path type. |
| `ingress.tls` | list | `[]` | TLS secrets/hosts. |

### Resources & Probes

| Key | Type | Default | Description |
|---|---|---:|---|
| `resources` | map | `{}` | CPU/Memory requests & limits. |
| `livenessProbe.httpGet.path` | string | `/` | HTTP path for liveness probe. |
| `livenessProbe.httpGet.port` | string | `http` | Port (name/number) for liveness probe. |
| `readinessProbe.httpGet.path` | string | `/` | HTTP path for readiness probe. |
| `readinessProbe.httpGet.port` | string | `http` | Port (name/number) for readiness probe. |

### Autoscaling (HPA)

| Key | Type | Default | Description |
|---|---|---:|---|
| `autoscaling.enabled` | bool | `false` | Enable HorizontalPodAutoscaler. |
| `autoscaling.minReplicas` | int | `1` | Minimum replicas. |
| `autoscaling.maxReplicas` | int | `100` | Maximum replicas. |
| `autoscaling.targetCPUUtilizationPercentage` | int | `80` | Target average CPU utilization. |
| `autoscaling.targetMemoryUtilizationPercentage` | int | _(unset)_ | Optional target memory utilization (commented in defaults). |

### Storage & Scheduling

| Key | Type | Default | Description |
|---|---|---:|---|
| `volumes` | list | `[]` | Extra volumes for the Deployment. |
| `volumeMounts` | list | `[]` | Extra volume mounts. |
| `nodeSelector` | map | `{}` | Node selection constraints. |
| `tolerations` | list | `[]` | Tolerations for taints. |
| `affinity` | map | `{}` | Pod affinity/anti-affinity rules. |

---

### Example: enable Ingress

```bash
helm install insight reconcile-kit/insight -n insight --set ingress.enabled=true --set ingress.hosts[0].host="insight.example.com"
```

All defaults above are sourced from the attached `values.yaml`. Adjust as needed for your environment.
