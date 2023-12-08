# Resources

## Request

- Provides Kubernetes with an idea of how many resources a container is expected to use
- The cluster uses this information to select a node that has enough resources available 
- What container grantee to get (not more but maybe equal or less)

## Limit

- Provides an upper limit on how many resources a container is allowed to use
- The cluster uses this information to terminates the container process if it attempts to use more than the allowed amount
- Container never go above this limit

## ResourceQuotas

Kubernetes object that sets limits on the resources used within a namespace. If creating of modifying a resource would 
go beyond this limit, the request will be denied. 


```yaml
    apiVersion: v1
    kind: ResourceQuota
    metadata:
        name: test
    spec:
        hard:
            # Maximum cpu combined by all containers in namespace can have
            requests.cpu: 500m
            requests.memory: 100Mib
            # Maximum cpu combined by all pods in namespace
            limits.cpu: 700m
            limits.memory: 500Mib
```