#! /bin/bash
# install-docker-ce.sh

echo "Installing dep lib ..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "Add GPG ..."
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

echo "Add docker version apt repo ..."
sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

echo "Install docker-ce ..."
sudo apt install -y docker-ce

echo "Add current user to docker group"
sudo usermod -aG docker $USER
