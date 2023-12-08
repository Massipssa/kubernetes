# install kubeadm
sudo kubeadm init  --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.27.0

# set kube config

kubectl apply -f https://docs.projectcalico/manifests/calico.yaml

# join worker nods
kubeadm token create --print-join-conmand
sudo kubeadm join [IP:PORT] --token [TOEK]