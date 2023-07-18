# Volumes

- Pods are ephemeral and stateless (can be deployed in any k8s environment)
- All containers running inside pod have access to the defined volume
- Volumes are associated to life cycle of pod
- Types
  - Ephemeral (goes when Pod dies)
  - Durable
- K8s supports multiple volumes as:
  - EmptyDir
  - hostPath
- Volumes can be used to  store state/data and use it in the pod 
    
## StorageClass

- A resource which defines in which quality the data will be stored (whether in cloud or locally)

## PersistentVolume
- How the applications running inside a Kubernetes cluster store the data (quality and directory)

## PersistentVolumeClaim

- Logically bind an application and the physical location of the data storage. They can be defined as an interface 
between the data storage and the application

