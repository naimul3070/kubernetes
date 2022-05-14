## Welcoem to iBOS DevOps Team.

#Prerequisites
## linux (Ubunto 20.4.4 LTS
## Fresh new OS (without install any service)

### Installation Guide Kubernetes A to Z

### For Master Node
### Install Docker,kubeadm,kubelet,kubectl,Openssh,Nginx,jare,Edit etc/fstab >> swap memory mount location

#### First we will work on master node and then we will creat the worker node

#### FOR EASY Installation we have create the sh file. Just clone the git repo in master node by run the command

    git clone https://github.com/naimul3070/kubernatis.git
    
### Get into the clone folde by run the command 

    ls
    
### and
    
    cd kubernatis/
    
#### give permisson the .sh file by run the command in (nust first move to the directory)

    chmod +x master.sh
    
#### Go to Master by using the comand

    sudo su -

#### Then run the .sh file for install the master node 
     
    sudo apt update
    sudo apt upgrade -y
    ./master.sh

# 1st worker 

#### after installation there will be a token like 

#####sample :  
kubeadm join 10.209.99.220:6443 --token yn0e71.7fy4apmhg060nuxp \
--discovery-token-ca-cert-hash sha256:b6445c3c7c29b96c042f00c98b544838d4954faccfa3001096281de340444357
######

### Just copy and run into worker node after make ready the worker node,

## For Worker Node 

### FOR EASY Installation we have create the sh file. just clone the repo using the git comand 

    git clone https://github.com/naimul3070/kubernatis.git
    

### Get into the clone folde by run the command 

    ls
    
### and
    
    cd kubernatis/
    
#### give permisson the .sh file by run the command in (nust first move to the directory)

    chmod +x worker.sh
 
#### Then run the .sh file for install the master node 
     
    sudo apt update
    sudo apt upgrade -y
    ./worker.sh

#### Check in master node by the command 

    kubectl get node
    
### If this is the first worker node then just follow the instracton in  ## 1st worker block

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
 
