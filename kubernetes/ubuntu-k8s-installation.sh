#!/bin/bash
echo "download docker.sh and install docker with get-docker.sh"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sleep 5s

echo "Install cri-dockerd"
wget https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x ./installer_linux
./installer_linux
source ~/.bash_profile
sleep 5s

echo "git clone https://github.com/Mirantis/cri-dockerd.git"
git clone https://github.com/Mirantis/cri-dockerd.git
cd cri-dockerd
mkdir bin
go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl start cri-docker.service
sleep 5s

echo "kubernetes installation starts here"
apt update
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl