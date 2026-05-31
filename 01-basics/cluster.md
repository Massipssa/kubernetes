# Cluster

A Kubernetes cluster is a set of machines that run containerized workloads. The control plane makes decisions, and worker nodes run Pods.

## Nodes

Useful commands:

```bash
kubectl cluster-info
kubectl get nodes
kubectl get nodes -o wide
kubectl describe node <node-name>
```

## Contexts

Contexts define which cluster, user, and namespace `kubectl` talks to.

```bash
kubectl config get-contexts
kubectl config current-context
kubectl config use-context <context-name>
```
