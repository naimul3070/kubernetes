## Welcoem to DevOps Learn.

#Prerequisites
## linux (Ububuntu-20.04.3-live-server-amd64.iso LTS)

### For Download <a href="https://old-releases.ubuntu.com/releases/20.04.3/ubuntu-20.04-beta-live-server-amd64.iso" color="green">CLICK HERE</a>

## Fresh new OS (without install any service)

### For Master Node

### Install Docker,kubeadm,kubelet,kubectl,Openssh,Nginx,jare,Edit etc/fstab >> swap memory mount location

#### First we will work on master node and then we will creat the worker node

#### FOR EASY Installation we have create the sh file. Just clone the git repo in master node by run the command
    git clone https://github.com/naimul3070/kubernetes.git&&cd kubernetes/&&chmod +x master.sh&&./master.sh
    
#### Just Press Y when you see this

<img width="419" alt="image" src="https://user-images.githubusercontent.com/50922314/172578341-bbaed7ad-74c7-4b58-b17d-3b3987dbdb1c.png">



### There will be token like image JUST COPY THAT KEEP SOME WHERE FOR next use

<img width="671" alt="image" src="https://user-images.githubusercontent.com/50922314/172582907-59912f27-8e23-4850-b6e9-e6b3bf5ed151.png">



### Get into the clone folde by run the command 
    ls
### and
    
#### give permisson the .sh file by run the command in (nust first move to the directory)
    chmod +x master.sh
#### Please Check the master fill is get permission by use che command
    ls
#### Then run the .sh file for install the master node 
    sudo apt update
    sudo apt upgrade -y
    ./master.sh
### for check run the command in master node for check the nodes status
    kubectl get node
# 1st worker 

#### after installation there will be a token like 

#####sample :  
kubeadm join 10.209.99.220:6443 --token yn0e71.7fy4apmhg060nuxp \
--discovery-token-ca-cert-hash sha256:b6445c3c7c29b96c042f00c98b544838d4954faccfa3001096281de340444357
######

### Just copy and run into worker node after make ready the worker node,

## For Worker Node 

### FOR EASY Installation we have create the sh file. just clone the repo using the git comand 
    git clone https://github.com/naimul3070/kubernetes.git&&cd kubernetes/&&chmod +x worker.sh&&./worker.sh
### Get into the clone folde by run the command 
    ls
### and
    cd kubernetes/
#### give permisson the .sh file by run the command in (nust first move to the directory)
    chmod +x worker.sh
#### Then run the .sh file for install the master node 
    sudo apt update
    sudo apt upgrade -y
    ./worker.sh
### If this is the first worker node then just follow the instracton in  ### 1st worker block and

#### Check in master node by the command 
    kubectl get node
# for multiple worker node

## after imstallation worker node need to create new token in master node and copy the token then run it in worker node.

#### run the comadn for see token list in master node 
    kubeadm token list
#### for create new token 
    sudo kubeadm token create --print-join-command
#### now copy the token and run to the worker node, 

### for check run the command in master node for check the nodes status
    kubectl get node
# Troubleshooting

#### if the node status in showiing not-ready just enable the docker and turn of the the swap memory of all-nodes

    sudo systemctl enable docker.service
    sudo swapoff -a

# Happy kubernatis ---- enjoy---
 
