
### get k3s


// export INSTALL_K3S_VERSION=v1.22.6+k3s1

curl -sfL https://get.k3s.io |  sh -

<!-- - wget https://github.com/k3s-io/k3s/releases/download/v1.23.3%2Bk3s1/k3s
- screen -d -m -L -Logfile /var/log/k3s.log /usr/local/bin/k3s server -->

k3s kubectl cluster-info && k3s kubectl get nodes && k3s kubectl get pods --all-namespaces

<!-- tail -F /var/log/k3s.log -->

- curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

- helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
- helm repo add jetstack https://charts.jetstack.io
- helm repo update



#### install / uninstall cert-manager
- k3s kubectl create namespace cert-manager
- kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml

<!-- - helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.7.1  -->

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1 \
  --set installCRDs=true

### uninstall
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces

helm --namespace cert-manager delete cert-manager

kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml

<!-- - helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager -->

- k3s kubectl get pods --namespace cert-manager

### install rancher

- k3s kubectl create namespace cattle-system

- helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.local
### check and start
- k3s check-config
- screen -d -m -L -Logfile /var/log/k3s.log /usr/local/bin/k3s server


k3s agent --server http://172.29.64.241:6443 --token K10bd74bf40e7f39dfaa4826e128d093562cb887ea3e93314458976ae89244e3dbb::server:80daf7334fd2e42918052b458edc026e


### reset k3s
rm -rf /etc/rancher/k3s
rm -rf /var/lib/rancher/k3s

# start from scratch
screen -d -m -L -Logfile /var/log/k3s.log /usr/local/bin/k3s server
k3s kubectl create namespace cattle-system
k3s kubectl create namespace cert-manager
k3s kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0-alpha.2/cert-manager.crds.yaml
helm install cert-manager jetstack/cert-manager --namespace cert-manager