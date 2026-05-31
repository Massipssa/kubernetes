param(
    [string]$LabId = "student1",
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

helm uninstall $ReleaseName -n $Namespace
kubectl delete namespace $Namespace

Write-Host "Deleted lab $LabId from namespace $Namespace."
