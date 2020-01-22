kubectl create ns nginx
helm install nginx stable/nginx-ingress --namespace nginx --version 1.27.0

kubectl patch service nginx-nginx-ingress-controller \
    -n nginx \
    -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.188.129"]}}'