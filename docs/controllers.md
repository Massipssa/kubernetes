# Controllers

- [Pod](#pod)
- [ReplicatSet](#rs)  
- [Deployment](#deployment)
- [Replication Controller (RC)](#rc)  
- [Job](#job)
- [StatefulSet](#statefulset)
- [DeamonSet](#deamonset)

## POD <a name="pod"></a>

- Scheduling unit in k8S
- Provides runtime environment for application that we deploy

- **Pod lifecycle**
    1. Submit file (yaml or json) to API Server
    2. Pods go to scheduler and they stay in ***Pending*** state until all scheduled they pass to ***Running***
    3. Pod may have:
        - **Succeed**
        - **Failed**: when Pod fails it cannot be recovered

- **Create**
    ```kubectl  create -f path/to/file.yml```

- **Get**
    ```kubectl  get pod```

- **Describe, delete, get**
    ```kubectl  <command>  pod [pod-name]```

## Replication Controller (RC) <a name="rc"></a>

- Ensures that the number of pods are running always at any time
- RC and Pods are linkend by labels
- Advantages:
    1. High availability
    2. Load balancing  (trafic equalty distributed)
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

## Deployment <a name="deployment"></a>

- Is controller  

### Feature

- Multiple replicas of pods
- Update
- Rollback
- Scale up or down
- Pause and resume (test and validate new versions)

### Types

- Recreate (when version 1 is shutdown start version 2) implies downtime of service
- RollingUpdate (Ramped or Incremental)
- Canary
- Blue / Green

#### update deployment

```kubectl set image deploy [deploy-name] [deploy-container]=image:verion```
**OR**
```kubectl edit deploy [deploy-name]```

#### Rollup deployment

```kubectl rollout undo deployment/[deploy-name]```

- Check status

```kubectl rollout status deployment/[deploy-name]```

#### Scale up and down

```kubectl scale deployment [deploy-name] --replicas=[replica-number]```

## Job <a name="job"> </a>

- Run repated tasks
- Is controller which supervise Pod to accomplish certain task

### Types

- Run to completion (Jobs)
    - Perform bash processing
    - Controller will wait for return code exit 0 to shutdown job
    - Must be deleted manually
- Scheduler (CronJob)
    - Similar to cron job in linux
    - Main purpose free space, dump logs,... repetelly

## DeamonSet <a name="deamonset"> </a>

* Ensure that all ((or some) nodes of cluster run one Pod of application
* Can be used to:
    * Deploy one Pod by node
    * Deploy one pod by subset of nodes (in this case we need to tag nodes by labels)
* Add and remove Pods as the nodes join or leave cluster
* Some uses cases:
    * Collect logs: install Filebeat, fluentd on every node
    * Monitoring: Prometheus on each node

## Basic commands

### Objects

- **Create**

    ```kubectl create -f /path/to/rc.yml```

- **Describe, delete, get ...**
    ```kubectl <command> rc [rc-name]```

- **Get all**
    ```kubectl get po -l app=[rc-name]```
    ```kubectl  get pod -o [format]```

- **Scale up and down**
    ```kubectl scale rc <rc-name> --replicas=[new-number]  ```
