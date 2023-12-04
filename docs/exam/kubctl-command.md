## Config Map

kubectl create cm config --from-literal=foo=lala --from-literal=foo2=lolo
kubectl get cm config -o yaml 
kubectl describe cm config

- create fom file
echo -e "foo=lala\nfoo1=lili" > config.txt
kubectl create cm --from-file=config.txt

- create from env file 
kubectl create cm --from-env-file=config.env

env: 
 -name: option
  valueFrom:
   configMapKeyRef: 
    name: options
    key: var5

envFrom:
 - configMapRef:
    name: anotherone


## Secrets

kubectl create  secret generic mysecret --from-literal=password=mypass
kubectl create  secret generic mysecret2 --from-file=username
kubectl get secret mysecret2 -o jsonpath='{.data.username}' | base64 -d
kubectl get secret mysecret2 --template {{.data.username}} | base64 -d
kubectl get secret mysecret2 -o json | jq -r .data.username | base64 -d

-- create a pod and mount secret on it
k run sngix --image=nginx --dry-run=client -o yaml > spod.yaml 
















