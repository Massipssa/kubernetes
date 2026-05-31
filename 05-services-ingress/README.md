# Services

- Way of grouping pods that are running inside the cluster
- Get a static IP address
- Node's **kube-proxy** creates virtual IP for services
- Labels and selectors are used to discover pods by the service
 
## Types

| Type | Use it for | Notes |
| --- | --- | --- |
| `ClusterIP` | Internal cluster access. | Default Service type. Gets a stable virtual IP reachable inside the cluster. |
| `NodePort` | Simple external access through every node. | Opens a port on each node, usually in the `30000-32767` range. |
| `LoadBalancer` | Production-style external access on cloud platforms. | Asks the cloud provider for an external load balancer. |
| `ExternalName` | DNS alias to a service outside the cluster. | Does not create selectors or endpoints. |
| Headless | Direct Pod discovery. | Uses `clusterIP: None`; DNS returns Pod IPs instead of a Service virtual IP. |

## Example Files

- [deployment.yml](deployment.yml): sample nginx Deployment selected by the Services.
- [service.yml](service.yml): internal `ClusterIP` Service.
- [nodeport-service.yml](nodeport-service.yml): optional `NodePort` Service for local demos.
- [headless-service.yml](headless-service.yml): headless Service example.
- [ingress.yml](ingress.yml): HTTP routing example that requires an Ingress controller.

## Try It

Run from this folder:

```bash
kubectl apply -f ../01-basics/namespace.yml
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl get pods -n dev -l app=nginx
kubectl get services,endpoints -n dev
```

Test the ClusterIP Service with port forwarding:

```bash
kubectl port-forward service/nginx-service 8080:80 -n dev
curl http://localhost:8080
```

On PowerShell, this also works:

```powershell
Invoke-WebRequest http://localhost:8080
```

Clean up:

```bash
kubectl delete -f service.yml
kubectl delete -f deployment.yml
```

## Ingress

- **Ingress Resource**
  - Define the rules 
  - Path-based routing 
  - Name-based virtual hosts
- **Ingress Controller:** It's a reverse proxy that implements the rules defined by a   
  Resource
- **Ingress Class:** associate Resource with Controller