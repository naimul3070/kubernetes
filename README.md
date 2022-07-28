## Welcome to DevOps Learn.
# ONE CLICK KUBERNETES master and WORKER NODES installation steps !!
## Prerequisites
## linux (Ububuntu-20.04.4-live-server-amd64.iso LTS)
### For Download Linux <a href="https://old-releases.ubuntu.com/releases/20.04.3/ubuntu-20.04-beta-live-server-amd64.iso" rel="nofollow" style="color:red;">CLICK HERE</a>

## For Master Node
#### FOR EASY Installation just Run the command in master PC USING ROOT USER
    sudo su
    git clone https://github.com/naimul3070/kubernetes.git&&cd kubernetes/&&chmod +x master.sh&&./master.sh
    
### Just Press Y when you IF see this

<img width="419" alt="image" src="https://user-images.githubusercontent.com/50922314/172578341-bbaed7ad-74c7-4b58-b17d-3b3987dbdb1c.png" class="center">

### There will be token like image JUST COPY THAT KEEP SOME WHERE FOR next use

<img width="671" alt="image" src="https://user-images.githubusercontent.com/50922314/172582907-59912f27-8e23-4850-b6e9-e6b3bf5ed151.png" class="center">

### for check run the command in master node for check the nodes status
    kubectl get node
    
# ==1st worker 

#### after installation there will be a token like 

# Example :  
kubeadm join 10.209.99.220:6443 --token yn0e71.7fy4apmhg060nuxp \
--discovery-token-ca-cert-hash sha256:b6445c3c7c29b96c042f00c98b544838d4954faccfa3001096281de340444357

### Just copy and run into worker node after make ready the worker node,
## For Worker Node 
### FOR EASY Installation JUST run the command in wokrer pc USING ROOT USER
    sudo su
    git clone https://github.com/naimul3070/kubernetes.git&&cd kubernetes/&&chmod +x worker.sh&&./worker.sh
    
### Just Press Y when you IF see this

<img width="419" alt="image" src="https://user-images.githubusercontent.com/50922314/172578341-bbaed7ad-74c7-4b58-b17d-3b3987dbdb1c.png" class="center">

### If this is the first worker node then just follow the instruton                            
# FOLLOW==1st worker

#### Check in master node by the command 
    kubectl get node
    
# for multiple worker node
## after installation worker node need to create new token in master node and copy the token then run it in worker node.

#### run the command for see token list in master node  
    kubeadm token list
#### for create new token 
    sudo kubeadm token create --print-join-command
#### now copy the token and run to the worker node, 

### for check run the command in master node for check the nodes status
    kubectl get node
# (If the Node is showing not ready) Troubleshooting

#### if the node status in showiing not-ready just enable the docker and turn of the the swap memory of all-nodes

    sudo systemctl enable docker.service
    sudo swapoff -a
# Metal llb ( metall llb is for assing a public ip where all the application can be access easily and this ip will be hold the main domain)

#### clone the library of metal LLB and namespace

    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
    
 #### Need to add ip for loadbalancing
 ## Create a YAML file name as metallb-configmap.yaml (its not mendotory)
    nano metallb-configmap.yaml
 ## copy all the file in yaml (in the braket we need to assing the ip for load balancing):
 
        apiVersion: v1
        kind: ConfigMap
        metadata:
          namespace: metallb-system
          name: config
        data:
          config: |
            address-pools:
            - name: default
              protocol: layer2
              addresses:
              - <ip-address-range-start>-<ip-address-range-stop>
      
# Excicute the command for apply

    kubectl apply -f metallb-configmap.yaml

# In this step we need to install helm chart and add the helm Repo ( helm is use to manage the kubernetes applications)          
        chmod +x helm.sh&&./helm.sh
        
# For check the helm and helm repo use the comadn below
### check helm list
        helm list
#### THe outPut      
<img width="475" alt="image" src="https://user-images.githubusercontent.com/50922314/172037458-37c6e7af-16e8-4817-92c4-e8a21dd4ed83.png">
#### Now check the repo lis by using the comand
        helm -n staging  repo list
        
<img width="475" alt="image" src="https://user-images.githubusercontent.com/50922314/181494706-41b936f6-5fe7-479f-9d1b-6119544b64fe.png">

# If you see this images your helm installation done

# In this step we will install nginx and cleate a new namesapce name as staging and will configur context and ingress controler to that spesific name spaace

    chmod +x nginxingressaddstaging.sh&&./nginxingressaddstaging.sh
# Now check the name space and ingress-nginx resources

#### For name sapce
    kubectl get ns
#### For ingress resources
    kubectl -n staging get all 	
    kubectl get svc
#### For check the pods
    kubectl get pods
    
# Now your Environment is Ready for pod deployment.You need to add ssl for if your configuring this all in your local server)
# Happy kubernetes ---- enjoy---
