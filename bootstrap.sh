#! /bin/bash
# bootstrap.sh

echo Run bootstrap...

export http_proxy='http://192.168.56.1:8118/'
export https_proxy='http://192.168.56.1:8118/'

sudo apt-get update
sudo apt-get -y dist-upgrade

sudo swapoff -a
sudo sed -i '/swap/s/^/#/' /etc/fstab

sudo apt-get install -y openssh-server
