### check if ingress in enables

1. minikube addons list / ingress enabled
2. kubectl get pods --namespace=kube-system => nginx-ingress-controller-6fc5bcc8c9-lmzrm pod is running
3. setup virtual host
   - sudo sh -c "echo `minikube ip` springjms.local >> /etc/hosts" [append minikube cluster ip to the host file]
