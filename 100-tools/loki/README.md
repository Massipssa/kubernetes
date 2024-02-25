

```
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install loki grafana/loki -n loki  --set grafana.enabled=true --create-namespace
```

## Deployment modes

- Simple Scalable mode
- Monolithic mode
- Microservices mode
