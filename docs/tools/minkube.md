# Minikube

## Install

``` curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
```

```
  sudo mkdir -p /usr/local/bin/
  sudo install minikube /usr/local/bin/
```
- Start, stop, delete ````minikube <command>````
- Enable addon ````minikube addons enable <addon-name>````
- Get dashboard url ````minikube dashboard --url````
- List addon ````minikube addons list````
