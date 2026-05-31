# DaemonSet

A DaemonSet ensures that every matching node runs one copy of a Pod.

Use DaemonSets for node-level agents such as:

- Log collectors.
- Monitoring agents.
- Storage plugins.
- Network plugins.

DaemonSets automatically add Pods when nodes join the cluster and remove Pods when nodes leave.

## Commands

```bash
kubectl apply -f controllers/examples/daemonSet.yml
kubectl get daemonsets -n dev
kubectl describe daemonset nginx-daemonset -n dev
kubectl delete -f controllers/examples/daemonSet.yml
```
