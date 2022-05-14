#!/bin/sh -x

apt-get install -y curl openssh-server

# Setup the kubernetes preprequisites
#
echo $(hostname -i) $(hostname) >> /etc/hosts
sudo sed -i "/swap/s/^/#/" /etc/fstab
sudo swapoff -a

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

# KUBE_DPKG_VERSION= 1.24.0
# DOCKER_VERSION= 20.10.15

apt-get update
apt-get install -y ebtables ethtool
apt-get install -y docker.io

cat <<EOF >/etc/docker/daemon.json
{
  "bip": "172.123.0.1/16"
}
EOF

systemctl daemon-reload
systemctl restart docker

apt-get install -y apt-transport-https
apt-get install kubelet 
apt-get install kubeadm
apt-get install kubectl


======== upto worker node and add the token from master =======
