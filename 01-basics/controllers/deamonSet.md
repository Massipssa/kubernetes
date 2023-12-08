## DeamonSet

- Ensure that all (or some) nodes of cluster run one Pod of application
- Can be used to:
  - Deploy one Pod by node
  - Deploy one pod by subset of nodes (in this case we need to tag nodes by labels)
- Add and remove Pods as the nodes join or leave cluster
- Some uses cases:
  - Collect logs: install Filebeat, fluentd on every node
  - Monitoring: Prometheus on each node