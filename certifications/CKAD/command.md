# Useful commands

## Create a pod

kubectl run nginx --image=nginx \
    --restart=Never \
    --dry-run=client \
    --port=80 \
    --labels=app=v1 \
    -n mynamespace -o yaml > pod.yaml

kubectl expose pod <pod-name> \
    --name=my-service \
    --port=80 \
    --type=NodePort \
    --dry-run=client -o yaml > myservice.yaml


kubectl create cj mycronjob \
    --name=mycronjob \
    --image=nginx:latest \
    --schedule="* * * * *" \
    --dry-run=client -o yaml > mycj.yaml


kubectl apply -f pod.yaml
kubectl run nginx --image=nginx --restart=Never --dry-run=client -o yaml | kubectl create -n mynamespace -f -
kubectl run busybox --image=busybox  --restart=Never -ti --rm --command -- env | kubectl create -f -

kubectl create ns  myns --dry-run=client
kubectl create quota myrq --hard=requests.cpu="1",requests.memory="1G",limits.cpu="2",limits.memory="2G",pods="2" --dry-run=client -o yaml

- Create multiple pods
```shell
for i in `seq 1 3`; do kubectl run nginx$i --image=nginx --labels=app=v1; done 
```

## Labels

- Add label: kubectl label pod nginx foo=bar
- Show labels: ubectl get pod nginx --show-labels
- Select by label: kubectl get pod --selector=foo=bar
- Overwrite: kubectl label pod nginx foo=v1 --overwrite
- Remove label: kubectl label pod nginx foo-

## Annotations

- Add annotation: k annotate po nginx description='This is desc'
- Overwrite: kubectl annotate pod nginx description='New desc' --overwrite
- Remove label: kubectl annotate pod nginx description-