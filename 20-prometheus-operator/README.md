[archi](imag/)

## Add Helm repository

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

## Install a release

```
helm install prometheus  prometheus-community/kube-prometheus-stack -n prometheus --create-namespace
```

- Forward the port

```
kubectl port-forward svc/prometheus-kube-prometheus-prometheus 9090:9090 -n prometheus
```

- Deploy an example with it service monitor

```
kubectl apply -f .\deploy.yaml -f .\servicemonitor.yaml
```

## Grafana

- Forward the port

```
kubectl port-forward svc/prometheus-grafana 3000:80 -n prometheus
```

- Login: default login information
    - username: admin
    - password: prom-operator