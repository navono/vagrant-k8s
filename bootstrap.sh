#! /bin/bash
# bootstrap.sh

echo I am bootstrap...
sudo swapoff -a
sudo apt-get install -y openssh-server