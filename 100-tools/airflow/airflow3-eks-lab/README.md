# Airflow 3 Lab on Amazon EKS

This MVP creates one isolated Apache Airflow 3 lab on Amazon EKS. The lab uses:

- `eksctl` for the demo EKS cluster.
- The official Apache Airflow Helm chart for the lab runtime.
- One Kubernetes namespace per lab.
- Built-in PostgreSQL from the chart for a quick MVP.
- Port-forward access by default, with optional AWS ALB ingress.

For production, move the metadata database to Amazon RDS, use a private image for DAGs and dependencies, store secrets in AWS Secrets Manager or External Secrets, and add TTL cleanup.

## Current Compatibility Notes

As of May 10, 2026, the stable Apache Airflow Helm chart documents:

- Kubernetes `1.30+`.
- Helm `3.10+`.
- Supported Airflow `2.11+` and `3.0+`.
- Current chart parameter defaults include Airflow `3.2.0`.

Official references:

- Apache Airflow Helm chart: https://airflow.apache.org/docs/helm-chart/stable/index.html
- Airflow chart parameters: https://airflow.apache.org/docs/helm-chart/stable/parameters-ref.html
- Airflow production guide: https://airflow.apache.org/docs/helm-chart/stable/production-guide.html
- Amazon EKS with `eksctl`: https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
- Amazon EBS CSI driver: https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
- AWS Load Balancer Controller: https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

## MVP Architecture

```text
POST /api/labs
  -> API validates user and lab template
  -> API stores lab record as creating
  -> worker runs helm upgrade --install
  -> EKS creates namespace, Airflow API server, scheduler, triggerer, PostgreSQL
  -> worker waits for Pods
  -> API marks lab as running and returns URL/status
```

For the first MVP, run the Helm command manually or from a simple worker. After the workflow is stable, wrap it behind the API described in [api-openapi.yaml](api-openapi.yaml).

## Repository Files

| File | Purpose |
| --- | --- |
| [eksctl-cluster.yaml](eksctl-cluster.yaml) | Minimal EKS cluster definition for a lab environment. |
| [storageclass-gp3.yaml](storageclass-gp3.yaml) | Default encrypted gp3 StorageClass for EBS CSI. |
| [airflow-values-mvp.yaml](airflow-values-mvp.yaml) | Minimal Airflow 3 Helm values for one lab. |
| [airflow-values-alb.yaml](airflow-values-alb.yaml) | Optional ALB ingress values for browser access without port-forward. |
| [api-openapi.yaml](api-openapi.yaml) | Minimal API contract for creating and deleting labs. |
| [lab-request.json](lab-request.json) | Example API request body. |
| [scripts/create-lab.ps1](scripts/create-lab.ps1) | PowerShell helper to create one Airflow lab. |
| [scripts/delete-lab.ps1](scripts/delete-lab.ps1) | PowerShell helper to delete one Airflow lab. |

## Step 1: Install Local Tools

Install and configure:

- AWS CLI v2.
- `eksctl`.
- `kubectl`.
- Helm 3.10 or later.

Check:

```bash
aws sts get-caller-identity
eksctl version
kubectl version --client
helm version
```

Set the values used by the examples:

```bash
export AWS_REGION=eu-west-3
export CLUSTER_NAME=airflow3-lab
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
```

PowerShell:

```powershell
$env:AWS_REGION = "eu-west-3"
$env:CLUSTER_NAME = "airflow3-lab"
$env:AWS_ACCOUNT_ID = aws sts get-caller-identity --query Account --output text
```

## Step 2: Create the EKS Cluster

From this folder:

```bash
eksctl create cluster -f eksctl-cluster.yaml
kubectl get nodes -o wide
```

The cluster file omits a fixed Kubernetes version so EKS can use a currently supported default. Confirm the cluster is Kubernetes `1.30+` before installing the current Airflow chart:

```bash
kubectl version
```

## Step 3: Add Persistent Volume Support

The Airflow Helm chart can run with its built-in PostgreSQL database for testing. On EKS, install the Amazon EBS CSI add-on before relying on dynamic PersistentVolumeClaims.

Create the IAM role for the EBS CSI driver:

```bash
eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --role-only \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve
```

Install the EBS CSI add-on:

```bash
aws eks create-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name aws-ebs-csi-driver \
  --service-account-role-arn "arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole" \
  --region "$AWS_REGION"
```

Create a default encrypted gp3 StorageClass:

```bash
kubectl apply -f storageclass-gp3.yaml
kubectl get storageclass
```

## Step 4: Install Airflow 3 with Helm

Add the official chart repo:

```bash
helm repo add apache-airflow https://airflow.apache.org --force-update
helm repo update apache-airflow
```

Create one lab:

```bash
export LAB_ID=student1
export NAMESPACE=lab-$LAB_ID-airflow3
export RELEASE_NAME=airflow-$LAB_ID

helm upgrade --install "$RELEASE_NAME" apache-airflow/airflow \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values airflow-values-mvp.yaml \
  --set-string createUserJob.defaultUser.password=admin \
  --wait \
  --timeout 15m
```

PowerShell helper:

```powershell
.\scripts\create-lab.ps1 -LabId student1 -AdminPassword admin
```

Check the lab:

```bash
kubectl get pods -n "$NAMESPACE"
helm list -n "$NAMESPACE"
```

## Step 5: Open the Airflow UI

Airflow 3 uses the API server component for the UI/API endpoint in the chart.

Use port-forward for the MVP:

```bash
kubectl port-forward "svc/$RELEASE_NAME-api-server" 8080:8080 -n "$NAMESPACE"
```

Open:

```text
http://localhost:8080
```

MVP credentials:

```text
username: admin
password: admin
```

Change the password before exposing a lab to other users.

## Step 6: Optional Public Access with AWS ALB

Install the AWS Load Balancer Controller if you want an internet-facing ALB for the lab.

Download and create the IAM policy:

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json
```

Create the controller service account role:

```bash
eksctl create iamserviceaccount \
  --cluster "$CLUSTER_NAME" \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn "arn:aws:iam::$AWS_ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy" \
  --override-existing-serviceaccounts \
  --region "$AWS_REGION" \
  --approve
```

Install the controller:

```bash
helm repo add eks https://aws.github.io/eks-charts --force-update
helm repo update eks

helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0
```

Create or update the lab with ALB ingress enabled:

```bash
export AIRFLOW_HOST=airflow-student1.example.com

helm upgrade --install "$RELEASE_NAME" apache-airflow/airflow \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values airflow-values-mvp.yaml \
  --values airflow-values-alb.yaml \
  --set-string "ingress.apiServer.hosts[0].name=$AIRFLOW_HOST" \
  --wait \
  --timeout 15m
```

Check the generated ALB hostname:

```bash
kubectl get ingress -n "$NAMESPACE"
```

Point your DNS record to the ALB hostname, or test by editing your local hosts file only when you know the ALB address you want to route to.

## Step 7: API MVP

The API should not run Helm inside the request thread. Use a worker:

1. `POST /api/labs` validates the request.
2. API inserts a `creating` lab row in the database.
3. API enqueues a job with `labId`, `namespace`, `releaseName`, and `ttlMinutes`.
4. Worker runs the Helm command.
5. Worker waits for Pods and Service/Ingress.
6. Worker updates the lab row to `running` or `failed`.
7. `DELETE /api/labs/{labId}` runs `helm uninstall` and deletes the namespace.

Example request:

```bash
curl -X POST http://localhost:8080/api/labs \
  -H "Content-Type: application/json" \
  --data @lab-request.json
```

Expected response:

```json
{
  "labId": "student1-airflow3",
  "status": "creating",
  "namespace": "lab-student1-airflow3",
  "releaseName": "airflow-student1",
  "url": null
}
```

The worker command behind this request is the same Helm command from Step 4.

## Step 8: Delete One Lab

```bash
helm uninstall "$RELEASE_NAME" -n "$NAMESPACE"
kubectl delete namespace "$NAMESPACE"
```

PowerShell helper:

```powershell
.\scripts\delete-lab.ps1 -LabId student1
```

## Step 9: Delete the EKS Cluster

When the MVP test is finished:

```bash
eksctl delete cluster --name "$CLUSTER_NAME" --region "$AWS_REGION"
```

This is important: EKS nodes, load balancers, and EBS volumes can create ongoing AWS charges.

## MVP Hardening Checklist

- Generate a unique namespace per lab.
- Set a `ResourceQuota` and `LimitRange` per namespace.
- Use unique admin passwords or SSO.
- Add TTL cleanup for abandoned labs.
- Prefer private ALBs or port-forward for internal training.
- Move production metadata DB to RDS.
- Use private DAG images or `gitSync` with read-only credentials.
- Store secrets outside `values.yaml`.
- Log lab creation/deletion events for audit.
