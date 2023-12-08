# Services

- Way of grouping pods that are running inside the cluster
- Get a static IP address
- Node's kube-proxy creates virtual IP for services
- Labels and selectors are used to discover pods by the service
 

## Types

- **ClusterIP** (default)
  - Reachable only within the cluster
- **Headless**
  - No IP address is assigned
- **NodePort**
  - Expose node to the outside
- **LoadBalancer**
  - App is distributed over cluster
- **ExternalName**
  - Maps a service to  DNS name 

## Ingress 

- **Ingress Resource**
  - Define the rules 
  - Path-based routing 
  - Name-based virtual hosts
- **Ingress Controller:** It's a reverse proxy that implements the rules defined by a Resource
- **Ingress Class:** associate Resource with Controller