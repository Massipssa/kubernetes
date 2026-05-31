# Services

A Service gives a stable network identity to a changing set of Pods.

Pods are ephemeral: they can be replaced, rescheduled, and assigned new IP addresses. A Service selects Pods by label and routes traffic to the healthy matching endpoints.

## How Services Work

- `spec.selector` finds the Pods that should receive traffic.
- `port` is the port exposed by the Service.
- `targetPort` is the Pod container port, or a named container port such as `http`.
- `kube-proxy` programs node networking rules so traffic reaches the selected Pods.
- CoreDNS creates DNS records for Services, for example `nginx-service.dev.svc.cluster.local`.

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

Ingress exposes HTTP and HTTPS routes from outside the cluster to Services inside the cluster.

- **Ingress resource:** declares routing rules, such as path-based routing and name-based virtual hosts.
- **Ingress controller:** the reverse proxy that implements those rules.
- **IngressClass:** associates an Ingress resource with the controller that should handle it.

The [ingress.yml](ingress.yml) example assumes an Ingress controller using the class name `nginx`.

## Troubleshooting

Check whether the Service has endpoints:

```bash
kubectl get endpoints nginx-service -n dev
```

If no endpoints are listed, compare the Service selector with the Pod labels:

```bash
kubectl describe service nginx-service -n dev
kubectl get pods -n dev --show-labels
```
