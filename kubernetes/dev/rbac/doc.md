1. Create private key 

```bash
    openssl genrsa -out john.key 2048
```

2. Create Certificate Siging Request (CSR) 

```bash
    openssl req -new -key john.key -out john.csr -subj "/CN=john/O=finance" 
```

3. Sign a certificate 

```bash
    openssl x509 -req -in john.csr -CA kubelet.crt -CAkey kubelet.key -CAcreateserial -out john.crt -days 365
``` 

4. Create a config file for user

```
    kubectl --kubeconfig john.kubeconfig config set-cluster kubernetes --server https://localhost:6443 --certificate-authority=kubelet.crt
```

5. Add user 

```
    kubectl --kubeconfig john.kubeconfig config set-credentials john \
        --client-certificate /home/massi/dev/kubernetes/keys/john.crt \
        --client-key /home/massi/dev/kubernetes/keys/john.key
```

6. Set the context 

````
    kubectl --kubeconfig john.kubeconfig config set-context john-kubernetes \ 
        --cluster kubernetes --namespace finance --user john
````


### Notes 
- By default, kubectl (and kubeless) look for config file in ```$HOME/.kube/config``` 
- Create ***Role***
    ```bash
        kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods --namespace=finance
    ````
  
### Minikube
- Enable addon ````minikube addons enable <addon-name>````
- Get dashoard url ````minikube dashboard --url````
- List addon ````minikube addons list````
