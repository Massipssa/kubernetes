# Deployment

A Deployment manages **stateless** application replicas. It creates and updates ReplicaSets, which then keep the desired number of Pods running.

Use Deployments for most long-running web services, APIs, workers, and stateless applications.

## Features

- Multiple replicas of the same Pod template.
- Rolling updates with controlled availability.
- Rollback to a previous revision.
- Scaling up or down.
- Pause and resume during a rollout.

## Update Strategies

- **Recreate:** stops old Pods before starting new ones. This can cause downtime.
- **RollingUpdate:** gradually replaces old Pods with new Pods. This is the default.
- **Canary:** releases to a small subset first. Usually implemented with Deployments plus routing or progressive delivery tooling.
- **Blue/Green:** runs two versions and switches traffic between them.

## Rollouts

A rollout is triggered when the Deployment Pod template changes, for example when the container image tag changes.

```bash
kubectl set image deployment/<deployment-name> <container-name>=<image>:<tag> -n dev
kubectl rollout status deployment/<deployment-name> -n dev
kubectl rollout history deployment/<deployment-name> -n dev
kubectl rollout undo deployment/<deployment-name> -n dev
```

## Scale

```bash
kubectl scale deployment <deployment-name> --replicas=5 -n dev
```
