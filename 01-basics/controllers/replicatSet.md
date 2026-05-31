# ReplicaSet

A ReplicaSet keeps a desired number of matching Pods running.

ReplicaSets and Pods are linked by labels:

- `spec.selector` defines which Pods the ReplicaSet owns.
- `spec.template.metadata.labels` defines the labels added to new Pods.
- The selector must match the Pod template labels.

In most applications, you create a Deployment and let the Deployment manage ReplicaSets for you.

## Commands

```bash
kubectl apply -f controllers/examples/rs.yml
kubectl get replicasets -n dev
kubectl describe replicaset nginx-rs -n dev
kubectl scale replicaset nginx-rs --replicas=5 -n dev
kubectl delete -f controllers/examples/rs.yml
```
