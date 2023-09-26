# Controllers

- [Pod](#pod)
- [ReplicatSet](#rs)  
- [Deployment](#deployment)
- [Replication Controller (RC)](#rc)  
- [Job](#job)
- [StatefulSet](#statefulset)
- [DeamonSet](#deamonset)



## Replication Controller (RC) <a name="rc"></a>

- Ensures that the number of pods are running always at any time
- RC and Pods are linked by labels
- Advantages:
    1. High availability
    2. Load balancing  (traffic equally distributed)
    3. RC is ***OLD*** and was replaced by ***ReplicatSet***

### Example

```yaml
    apiVersion: v1
    kind: ReplicationController
    metadata:
        # name of rc
        name: ngix-rc
    spec:
        # nb of replicas to have all time
        replicas: 3
        # link between RC and Pods is by selector and labels
        selector:
            app: ngix-app
        # pods to run
        template:
            metadata:
                name: ngix-pod
                labels:
                    app: ngix-app
            spec:
                containers:
                - name: ngix-container
                image: ngix  
                ports:
                    - containerPort: 80
```

## ReplicatSet

- Ensures that a number of pods is running always at any time
- ReplicaSet and Pods are linked by ***labels***

- **Equality-based**:
    - =, ==, !=
        ```kubectl get pods -l environment=production```
- **Set-based**
    - in, notin, exists
    - ```kubectl get pods -l environment in (production)```

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  # name of rs
  name: nginx-rs
spec:
  # nb of replicas to have all time
  replicas: 3
  # link between RS and Pods is by selector and labels
  selector:
    # when have one value
    matchLabels:
        app: nginx-app
    matchExpressions:
        - {key: tier, operator: In, values: [frontend]}
  # pods to run
  template:
    metadata:
      name: nginx-pod
      labels:
        app: nginx-app
        tier: frontend
    spec:
      containers:
      - name: nginx-container
        image: nginx
        ports:
          - containerPort: 80
```



## DeamonSet <a name="deamonset"> </a>

- Ensure that all ((or some) nodes of cluster run one Pod of application
- Can be used to:
  - Deploy one Pod by node
  - Deploy one pod by subset of nodes (in this case we need to tag nodes by labels)
- Add and remove Pods as the nodes join or leave cluster
- Some uses cases:
  - Collect logs: install Filebeat, fluentd on every node
  - Monitoring: Prometheus on each node

## Basic commands

### Objects

- **Create**

    ```kubectl create -f /path/to/rc.yml```

- **Describe, delete, get ...**
    ```kubectl <command> rc [rc-name]```

- **Get all**
    ```kubectl get po -l app=[rc-name]```
    ```kubectl get pod -o [format]```

- **Scale up and down**
    ```kubectl scale rc <rc-name> --replicas=[new-number]  ```
