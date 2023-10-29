- Add the latest helm repository for the ingress-nginx

``helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx``

- Use helm to install an NGINX Ingress controller:

``helm install quickstart ingress-nginx/ingress-nginx``

- Deploy 

``kubectl apply -f deployment.yaml -f ser


## Auto signed certificate 

1. Create a certificate and a private key using openssl 

```bash
openssl req -nodes -x509 -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt \
-subj "/C=FR/ST=Ile de France/L=Paris/O=IT/OU=IT/CN=massi.example.com" 
```

2. Create a secret

```bash
kubectl create secret tls tls-secret --key tls.key --cert tls.crt
```
