#! /bin/bash
# start-k8s-master.sh

echo "Staring cluster master ..."
#sudo kubeadm init --kubernetes-version=v1.11.3 --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.56.100

#sudo kubeadm init --pod-network-cidr=<> --apiserver-advertise-address=<ip-address-of-master>

# calico
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.56.100

# flannel
#sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.100

echo "Apply config ..."	
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config



# kubectl taint nodes --all node-role.kubernetes.io/master-

# kubectl describe node master | grep -A 10 Taint
# kubectl taint nodes --all node-role.kubernetes.io/master-
# kubectl taint nodes --all node.kubernetes.io/not-ready-


node.kubernetes.io/not-ready


kubectl describe node master | grep Taint

echo "Apply calico ..."
# Installing with the etcd datastore
# In the ConfigMap named calico-config, set the value of etcd_endpoints to the IP address and port of your etcd server.
# curl https://docs.projectcalico.org/v3.6/getting-started/kubernetes/installation/hosted/calico.yaml -O

echo "Modify calico.yaml in the ConfigMap with etcd server ip and port..."
echo "and then `kubectl apply -f calico.yaml`"
# aplly calico
# kubectl apply -f calico.yaml

# https://raw.githubusercontent.com/navono/kubernetes-cluster/master/calico/calico.yaml
# https://raw.githubusercontent.com/navono/kubernetes-cluster/master/calico/rbac-kdd.yaml

kubectl apply -f https://docs.projectcalico.org/v3.6/getting-started/kubernetes/installation/hosted/calico.yaml

#kubectl taint nodes --all node-role.kubernetes.io/master-
