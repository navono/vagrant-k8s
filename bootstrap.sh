#! /bin/bash
# bootstrap.sh

echo Run bootstrap...

sudo apt-get update
sudo apt-get -y dist-upgrade

sudo swapoff -a
sudo sed -i '/swap/s/^/#/' /etc/fstab

sudo apt-get install -y openssh-server
