#! /bin/bash
# install-docker-ce.sh

export http_proxy='http://192.168.56.1:8118/'
export https_proxy='http://192.168.56.1:8118/'

echo "Installing dep lib ..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Add GPG ..."
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

echo "Add docker version apt repo ..."
sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

echo "Install docker-ce ..."
sudo apt-get install -y docker-ce

echo "Add current user to docker group"
sudo usermod -aG docker $USER

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo cat <<EOF >/etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://192.168.56.1:8118/"
Environment="HTTPS_PROXY=http://192.168.56.1:8118/"
EOF

sudo cat <<EOF >/etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
