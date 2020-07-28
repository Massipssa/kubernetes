# Resources

## Request

* What container grantee to get

## Limit

* Container never go above this limit

## ResourceQuotas

```yaml
    apiVersion: v1
    kind: ResourceQuota
    metadata:
        name: test
    spec:
        hard:
            # Maximum cpu combined by all containers in namespace can have
            requests.cpu: 500m
            requests.merory: 100Mib
            # Maximum cpu combined by all pods in namespace
            limits.cpu: 700m
            limits.memory: 500Mib
```