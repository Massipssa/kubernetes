# Kubernetes

* Container design to do one thing, and it is: 
	* Faster
	* Reliable 
	* Efficient 
	* Light-weight 
	* Scalable 
* The fact that containers are scalable we need tool to manage them 

* Container Management tool which 
	* Automates container deployment
	* Container (de) scaling 
	* Container load balancing 


### Architecture

* Master/Salve architecture 
* ***Worker node*** contains 
    * **Pod**:
        * Scheduling unit in k8S
        * Consists of one or more containers (most cases one container)
    * **Container**: 
        * Runtime environment of an image 
        * Designed to run microservices applications
* ***Master***
    * Manages full cluster 
    * Monitor the healthckech of nodes 
    * Responsible for: 
        * Scheduling 
        * Provisiong
        * Controlling 
        * Exposing API to client 

<img src="./screeshots/archi_1.PNG"> 

### Components 

1. **Master**
    * **API**
        * Acts as gate a keeper of the cluster
        * Actions (GET, DELETE, ...) go throught the API
    * **API Server**
        * Validates and configure API objects such as pods, services ...
        * Responsible for exposing various APIs
    * **Scheduler**
        * Schedules Pods across multiple nodes
    * **Controller Manager**
        * There are four controllers
            * Node controller
            * Replication controller
            * End-point Controller
            * Service controller
        * All controllers are responsible for health of cluster
    * **etcd**
        * Key-value distributed light-weight database
        * Stores current states of the cluster

<img src="./screeshots/master_cmpts.PNG"> 

2. **Worker**
    * **Kubelet**
        * Primary node engine that runs in worker node 
        * Ensure that containers inside Pods are running, if not it will try to restart pods in the same worker. If the issue is du to worker itself it will try to start it in another worker node.
    * **Kube-proxy**
        * Maintains the entire internet configuration
        * Maintains networks distribued network across all nodes 
    * **Pods**
    * **Containers**

<img src="./screeshots/worker_cmpts.PNG"> 

3. Tools to interact with API
    * Kubectl
    * Minikube
