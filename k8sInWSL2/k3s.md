
### get k3s

- wget https://github.com/k3s-io/k3s/releases/download/v1.22.6%2Bk3s1/k3s
- curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

### check and start
- k3s check-config
- screen -d -m -L -Logfile /var/log/k3s.log /usr/local/bin/k3s server

### reset k3s
rm -rf /etc/rancher/k3s
rm -rf /var/lib/rancher/k3s

# start from scratch
screen -d -m -L -Logfile /var/log/k3s.log /usr/local/bin/k3s server
k3s kubectl create namespace cattle-system
k3s kubectl create namespace cert-manager
k3s kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0-alpha.2/cert-manager.crds.yaml
helm install cert-manager jetstack/cert-manager --namespace cert-manager