param(
    [string]$LabId = "student1",
    [string]$AdminPassword = "admin",
    [string]$Hostname = "",
    [string]$ReleaseName = "",
    [string]$Namespace = ""
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

if (-not $ReleaseName) {
    $ReleaseName = "airflow-$LabId"
}

if (-not $Namespace) {
    $Namespace = "lab-$LabId-airflow3"
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$valuesFile = Join-Path $repoRoot "airflow-values-mvp.yaml"
$albValuesFile = Join-Path $repoRoot "airflow-values-alb.yaml"

helm repo add apache-airflow https://airflow.apache.org --force-update
helm repo update apache-airflow

$helmArgs = @(
    "upgrade",
    "--install",
    $ReleaseName,
    "apache-airflow/airflow",
    "--namespace",
    $Namespace,
    "--create-namespace",
    "--values",
    $valuesFile,
    "--set-string",
    "createUserJob.defaultUser.password=$AdminPassword",
    "--wait",
    "--timeout",
    "15m"
)

if ($Hostname) {
    $helmArgs += @(
        "--values",
        $albValuesFile,
        "--set-string",
        "ingress.apiServer.hosts[0].name=$Hostname"
    )
}

helm @helmArgs
kubectl get pods -n $Namespace

Write-Host ""
Write-Host "Lab namespace: $Namespace"
Write-Host "Helm release:  $ReleaseName"
if ($Hostname) {
    Write-Host "Check ingress: kubectl get ingress -n $Namespace"
} else {
    Write-Host "Open UI: kubectl port-forward svc/$ReleaseName-api-server 8080:8080 -n $Namespace"
}
