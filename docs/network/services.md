# Services

- Way of grouping pods that are running inside the cluster
- Node's kube-proxy creates virtual IP for services
- Labels and selectors are used to discover pods by the service
 

## Types

- **ClusterIP** (default)
  - Reachable only within the cluster
- **NodePort**
  - Expose node to the outside
- **LoadBalancer**
  - App is distributed over cluster
- ExternalName
  - Maps a service to  DNS name 
