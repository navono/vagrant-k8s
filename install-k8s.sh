#! /bin/bash
# install-k8s.sh

echo Run k8s installation...

export http_proxy='http://192.168.56.1:8118/'
export https_proxy='http://192.168.56.1:8118/'

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://mirrors.ustc.edu.cn/kubernetes/apt/ kubernetes-xenial main
EOF

sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl
