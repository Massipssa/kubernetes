# Common kubectl Operations

## Label Selectors

Labels are key-value pairs attached to objects. Selectors let you filter objects by those labels.

### Equality-Based Selectors

```bash
kubectl get pods -l environment=production
kubectl get pods -l tier!=frontend
kubectl get pods -l app=nginx,tier=frontend
```

### Set-Based Selectors

Quote set-based selectors so your shell does not interpret the parentheses.

```bash
kubectl get pods -l 'environment in (production,staging)'
kubectl get pods -l 'tier notin (frontend,cache)'
kubectl get pods -l 'app'
```

## Output Formats

```bash
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName
```
