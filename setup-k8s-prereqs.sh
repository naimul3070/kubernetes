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

KUBE_DPKG_VERSION=1.24
DOCKER_VERSION= 19.03.15ubuntu1~20.4

apt-get update
apt-get install -y ebtables ethtool
apt-get install -y docker.io=$DOCKER_VERSION

cat <<EOF >/etc/docker/daemon.json
{
  "bip": "172.123.0.1/16"
}
EOF

systemctl daemon-reload
systemctl restart docker

apt-get install -y apt-transport-https
apt-get install -y kubelet=$KUBE_DPKG_VERSION kubeadm=$KUBE_DPKG_VERSION kubectl=$KUBE_DPKG_VERSION
apt-mark hold docker.io kubelet kubeadm kubectl

# curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

sudo systemctl enable docker
sudo systemctl enable kubelet

. /etc/os-release
if [ "$UBUNTU_CODENAME" = "bionic" ]; then
    modprobe br_netfilter
fi
sysctl net.bridge.bridge-nf-call-iptables=1
