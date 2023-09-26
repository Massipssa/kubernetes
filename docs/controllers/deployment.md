# Deployment

- It's a controller  
- Ensures that at least 75% of desired Pods are up (25% max unavailable) 
- Ensures that only a certain number of Pods are created above the desired number of Pods
- It ensures that at most 125% of the desired number of Pods are up (25% max surge)

## Feature

- Multiple replicas of pods
- Update 
- Rollback
- Scale up or down
- Pause and resume (test and validate new versions)

## Types

- Recreate (when version 1 is shutdown start version 2) implies downtime of service
- RollingUpdate (Ramped or Incremental)
- Canary
- Blue / Green

## Update deployment (rollout)

- Allows to change a deployment's Pod template, gradually replacing replicas with zero downtime
- Deployment's roll out is triggered  if and only if the Deployment's Pod template (that is, .spec.template) is changed

```kubectl set image deploy [deploy-name] [deploy-container]=image:verion```

**OR**

```kubectl edit deploy [deploy-name]```

- Undo

```kubectl rollout undo deployment/[deploy-name]```

- Check status

```kubectl rollout status deployment/[deploy-name]```

## Scale up and down

```kubectl scale deployment [deploy-name] --replicas=[replica-number]```
