#! /bin/bash
# install-k8s.sh

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s http://packages.faasx.com/google/apt/doc/apt-key.gpg | sudo apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://mirrors.ustc.edu.cn/kubernetes/apt/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl