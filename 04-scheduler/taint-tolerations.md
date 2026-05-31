# Scheduling

- Scheduler is responsible for scheduling
- Select a node to start a Pod on
- Default scheduler is **kube-scheduler**
- Two thing are considered
- Resources (cpu, memory, storage, ..)
- Policy
  - Node selector
  - Affinity
  - Taints and toleration's
  - Node cordoning
  - Manual scheduling

## Taint and Toleration

- taints are set on the nodes

<<<<<<< HEAD
 ```k taint nodes node-name key=value:taint-effect```

- Taint effect: what happens to the pods if they do not tolerate the taint
  - **NoSchedule:** pod will not be scheduled on the node
  - **PreferNoSchedule:** the system will try to avoid placing the pod in the node, but it's not guaranteed
  - **NoExecute:** Pods that do not tolerate the taint are evicted immediately, _tolerationSeconds_  is used for other
    pods.
=======
 ```kubectl taint nodes <node-name> key=value:taint-effect```
 
 - Taint effect: what happens to the pods if they do not tolerate the taint 
	- **NoSchedule:** pod will not be scheduled on the node
	- **PreferNoSchedule:** the system will try to avoid placing the pod in the node, but it's not guaranteed 
	- **NoExecute:** Pods that do not tolerate the taint are evicted immediately, _tolerationSeconds_  is used for other pods. 
>>>>>>> d94b69db8202b826f68649d109c0ead73aa42a43

- The toleration are set on the pods

```yaml
 tolerations:
 - key: app
   operator: "Equal"
   value: "blue"
   effect: "NoSchedule"
```
