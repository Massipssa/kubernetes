# Role Based Access Control (RBAC)

## Subject (Identities)

- **User**
  - Not represented by a kubernetes object 
  - Usually authenticates using a client certificate
  - Usually used by human users or tools running outside the cluster
- **Group**

- **Service Account**
  - Represented by a Kubernetes object 
  - Usually authenticates using an APO token 
  - Usually used by automated processes running within containers

- **Role**: what's you can do to set of resources
- **RoleBinding**: grant role to subject

## How to enable RBAC ??