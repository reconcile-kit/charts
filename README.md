# Reconcile-Kit Helm charts

A production-ready Helm chart to deploy the open-source [**Reconcile Kit**](https://github.com/reconcile-kit) applications on Kubernetes.

---

## Prerequisites

* Kubernetes cluster
* Helm 3.x installed

---

## Instructions

### Add a helm chart repository

Add helm chart repository for your local helm environment:

```bash
helm repo add reconcile-kit https://reconcile-kit.github.io/charts/

helm repo update
```

List all charts and versions of reconcile-kit repository:

```bash
helm search repo reconcile-kit
```

In command result you will see existing charts and versions:

```bash
NAME                            CHART VERSION   APP VERSION     DESCRIPTION                                       
reconcile-kit/insight           0.1.0           0.0.10          Helm Chart for deploying to Kubernetes of servi...
reconcile-kit/state-manager     0.4.0           0.0.11          Helm Chart for deploying to Kubernetes of servi...
```

### Installing the charts

Get the default values from chart:

```bash
helm show values reconcile-kit/state-manager > values.yaml
```

Than change the values.yaml to your values. After that you can install chart to your Kubernetes cluster:

```bash
# You can add "--debug --dry-run" args to debug your installation
helm install state-manager reconcile-kit/state-manager -f values.yaml -n target-namespace
```

## List of Charts

- [state-manager](https://github.com/reconcile-kit/charts/tree/main/charts/state-manager)
- [insight](https://github.com/reconcile-kit/charts/tree/main/charts/insight)