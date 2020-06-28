# Volumes

* Pods are ephemeral and stateless (can be deployed in any k8s environment)
* All containers running inside pod have access to the defined volume
* Volumes are associated to life cycle of pod
* Types
    * Ephemeral (goes when Pod dies)
    * Durable
* K8s supports multiple volumes as:
    * EmptyDir
    * hostPath
