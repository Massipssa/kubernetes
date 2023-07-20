# Config

## ConfigMap

- K8s object which to help handle configuration with container
- Way to make images portable
* K8s object that helps to handle configuration inside container
* Way to make the images portable
* Create:

    ```kubectl create configmap <map-name> <data-source>```

- ```data-source``` : --from-file: path to dir/file  
- ```data-source``` : --from-literal: key-value pair

## Examples

- Create from file
    ```kubectl create configmap test-configmap-1 --from-file=[path-to-file]```
- Create from env-file
    ```kubectl create configmap test-configmap-1 --from-env-file=[path-to-file]```
- Create from literal
    ```kubectl create configmap test-configmap-2 --from-literal=key1=value1```

- Pass configMap to pod using:
  - Volumes
  - Env variables

## Secret

- K8s object to handle small amount of sensitive data (password, Tokens or Keys)
- Stored inside ETCD database on k8s master
- Max size is 1MB
- Sent only to target node when it's needed (not broadcasted)

- Create:
  - Using kubectl
    ```kubectl create secret [TYPE] [NAME] [DATA] ```
  - Type
      - Generic (file, Directory, Literal value)
      - Docker-registry
      - tls
  - Data 
    - Path to dir/file:  **--from-file**
    - key-value pair: **--from-literal**

### Examples

```bash
    echo -n 'test12458' > ./password.txt
    kubectl create secret generic secret-password --from-file=./password.txt
```
