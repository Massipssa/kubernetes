1. Create namespace

```bash 
    kubectl create namespace elk-cluster
```

2. port-forward

```bash
    kubectl port-forward es-cluster-0 9200:9200 --namespace=kube-logging
```

- Downward API manages reflexion

- load env variables with ***valueFrom***
    - filedRef
    - resourceFieldRef
    - configMapRef
    
- **initContainers**: they are useful to run utilies like **sed, awk, python** which may not be present in image application
    
    