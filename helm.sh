#Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

#Add Helm Repo
helm -n staging repo add ingress-nginx https://kubernetes.github.io/ingress-nginx	
helm -n staging repo add  stable https://charts.helm.sh/stable	
helm repo add nginx-stable https://helm.nginx.com/stable
helm -n staging  repo update