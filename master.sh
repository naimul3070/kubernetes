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


apt-mark hold docker.io kubelet kubeadm kubectl

# curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

sudo systemctl enable docker
sudo systemctl enable kubelet


## start

. /etc/os-release
if [ "$UBUNTU_CODENAME" = "bionic" ]; then
    modprobe br_netfilter
fi
sysctl net.bridge.bridge-nf-call-iptables=1

##End


#!/bin/sh -x

# Initialize a kubernetes cluster on the current node.
#
# KUBE_VERSION=1.23
sudo kubeadm init --pod-network-cidr=10.244.0.0/16


======================= for add multiple worker need to remvoe previus token and genaarate new=====================  BY-=================

##sudo kubeadm token create --print-join-command


========================     ========================================

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# kubectl apply -f rbac.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard