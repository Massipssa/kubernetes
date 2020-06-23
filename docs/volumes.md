# Volumes

* Pods are ephemeral and stateless (can be deployed in any k8s environment)
* All containers runnning inside pod have acces to defined volume
* Volume are assocaited to life cycle of pod
* Types
    * Emphemeral (goes when Pod dies)
    * Durable
* K8s supports multiple volumes
    * EmptyDir
    * hostPath
