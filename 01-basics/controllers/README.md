# Controllers

Controllers watch Kubernetes objects and continuously move the cluster toward the desired state declared in those objects.

| Object | Use it for | Notes |
| --- | --- | --- |
| [Pod](pod.md) | The smallest schedulable workload unit. | Usually managed by a controller rather than created directly. |
| [Deployment](deployment.md) | Stateless applications that need replicas, rolling updates, and rollback. | The default choice for most long-running apps. |
| [ReplicaSet](replicatSet.md) | Keeping a fixed number of identical Pods running. | Usually created by a Deployment. |
| [ReplicationController](replicationController.md) | Legacy replica management. | Prefer Deployment or ReplicaSet for new workloads. |
| [Job](job.md) | Finite work that should run to completion. | CronJob schedules Jobs repeatedly. |
| [DaemonSet](deamonSet.md) | One Pod per node, or per matching node. | Useful for node agents such as log collectors. |

## Try the Examples

Run these commands from `01-basics`:

```bash
kubectl apply -f namespace.yml
kubectl apply -f controllers/examples/deployment.yml
kubectl get pods -n dev
kubectl delete -f controllers/examples/deployment.yml
```
