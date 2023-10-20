# Scheduling

- Scheduler is reponsible for scheduling 
- Select a node to start a Pod on 
- Default scheduler is kube-scheduler
- Two thing are considered 
 - Resources (cpu, memory, storage, ..)
 - Policy
	- Node selector 
	- Affinity 
	- Taints and tolerations
	- Node cordoning 
	- Manual scheduling

- taints are set on the nodes
 k taint nodes node-name key=value:taint-effect
 - taint effect: what happens to the pods if they do not tolerate the taint 
	- NoSchedule: pod will not be scheduled on the node
	- PreferNoSchedule: the system will try to avoid placing your pod in the pod but it's not garanteed 
	- NoExecute

- tolerations are set on pods

 tolerations:
 - key: app
   operator: "Equal"
   value: "blue"
   effect: "NoSchedule"
 
