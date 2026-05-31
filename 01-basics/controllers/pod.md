# Pod

A Pod is the smallest schedulable unit in Kubernetes. It provides the runtime environment for one or more containers that need to share networking, storage, and lifecycle.

Most production Pods are created through controllers such as Deployments, Jobs, CronJobs, and DaemonSets.

## Lifecycle

1. You submit a YAML or JSON manifest to the API server.
2. The scheduler assigns the Pod to a node.
3. The kubelet on that node starts the containers.
4. The Pod reports a phase such as `Pending`, `Running`, `Succeeded`, or `Failed`.

Pods are disposable. If a standalone Pod fails, Kubernetes does not create a replacement unless a controller owns it.

## Commands

```bash
kubectl apply -f controllers/examples/pod.yml
kubectl get pods -n dev
kubectl describe pod nginx-pod -n dev
kubectl logs nginx-pod -n dev
kubectl delete pod nginx-pod -n dev
```

## Multi-Container Pods

Use multiple containers in one Pod only when the containers are tightly coupled and need to share resources such as the same network namespace or volumes.

Common patterns:

- **Sidecar:** assists the main container, for example log shipping or file synchronization.
- **Ambassador:** proxies traffic to or from the main container.
- **Adapter:** transforms output from the main container into another format.

## Init Containers

An init container runs to completion before the main application containers start.

Use init containers to:

- Run startup tasks with tools that are not needed in the main image.
- Delay application startup until a dependency is ready.
- Isolate sensitive setup work from the main container.
