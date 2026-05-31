# ReplicationController

A ReplicationController keeps a desired number of matching Pods running. It is an older workload object and has mostly been replaced by ReplicaSet and Deployment.

Use a ReplicationController only when maintaining legacy manifests. For new workloads, prefer a Deployment.

## Benefits

- Keeps the requested number of Pods available.
- Replaces failed Pods.
- Can scale replicas up or down.

## Commands

```bash
kubectl apply -f controllers/examples/rc.yml
kubectl get replicationcontrollers -n dev
kubectl scale replicationcontroller nginx-rc --replicas=5 -n dev
kubectl delete -f controllers/examples/rc.yml
```
