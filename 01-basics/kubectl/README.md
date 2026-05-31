# kubectl Basics

`kubectl` is the command-line client for the Kubernetes API. Most day-to-day work is creating, reading, updating, and deleting Kubernetes objects.

## Create or Update Objects

Prefer `apply` for manifests that you keep in source control:

```bash
kubectl apply -f namespace.yml
kubectl apply -f controllers/examples/deployment.yml
```

Use `create` for one-off objects:

```bash
kubectl create namespace dev
```

## Inspect Objects

```bash
kubectl get pods -n dev
kubectl get pods -n dev -o wide
kubectl describe pod <pod-name> -n dev
kubectl logs <pod-name> -n dev
```

## Change Objects

```bash
kubectl edit deployment <deployment-name> -n dev
kubectl scale deployment <deployment-name> --replicas=3 -n dev
kubectl rollout status deployment/<deployment-name> -n dev
kubectl rollout undo deployment/<deployment-name> -n dev
```

## Delete Objects

```bash
kubectl delete -f controllers/examples/deployment.yml
kubectl delete pod <pod-name> -n dev
```

## Run Commands in a Pod

```bash
kubectl exec -it <pod-name> -n dev -- sh
kubectl exec <pod-name> -n dev -- printenv
```

## Check Permissions

```bash
kubectl auth can-i list pods -n dev
kubectl auth can-i create deployments -n dev
```
