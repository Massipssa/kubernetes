- Deploy vault

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault
helm search repo hashicorp/vault --versions
helm install vault hashicorp/vault \
    --set "server.dev.enabled=true" \
    --set "injector.enabled=false" \
    --set "csi.enabled=true"
```

Forward the port if you plan to use UI to create secrets, policies, ...

```
kubectl port-forward svc/vault 8200:8200
```

The default token is ``root``. 


- Enable kv secrets engine

```
vault kv put secrets/my-pass password="fake"
```

- Enable kubernetes secrets engine

```
vault auth enable kubernetes
vault write auth/kubernetes/config kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"
```

- Add policy to read from kv

```
vault policy write read-only - <<EOF
path "secret/data/my-pass" {
  capabilities = ["read"]
}
EOF
```  

- Create a role

vault write auth/kubernetes/role/mysecret \
    bound_service_account_names=secret-sa \
    bound_service_account_namespaces=default \
    policies=read-only \
    ttl=20m

- Install Secrets Store CSI

```
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system
```
