## Install Minikube

``` curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube```

```
  sudo mkdir -p /usr/local/bin/
  sudo install minikube /usr/local/bin/
```
- Start, stop, delete ````minikube <command>````
- Enable addon ````minikube addons enable <addon-name>````
- Get dashboard url ````minikube dashboard --url````
- List addon ````minikube addons list````

## Install kubectl

You'll find the requirements to install kubectl in this link: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
