kubectl run nginx --image=nginx \
    --restart=Never \
    --dry-run=client \
    --port=80 \
    --labels=app=v1 \
    -n mynamespace -o yaml > pod.yaml

kubectl apply -f pod.yaml 
kubectl run nginx --image=nginx --restart=Never --dry-run=client -o yaml | kubectl create -n mynamespace -f -
kubectl run busybox --image=busybox  --restart=Never -ti --rm --command -- env | kubectl create -f - 

kubectl create ns  myns --dry-run=client   
kubectl create quota myrq --hard=requests.cpu="1",requests.memory="1G",limits.cpu="2",limits.memory="2G",pods="2" --dry-run=client -o yaml


- Create multiple pods
```shell
for i in `seq 1 3`; do kubectl run nginx$i --image=nginx --labels=app=v1; done 
```