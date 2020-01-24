### set up gcp k8s nodes

#### setup vpc

1. gcloud compute networks create vke-network --subnet-mode custom

#### setup subnet

1. gcloud compute networks subnets create subnet-0 --network=vke-network --range=172.16.1.0/24 --region=us-east1

#### create firewall rules

1. gcloud compute firewall-rules create public-ssh --network=vke-network --allow="tcp:22" --source-ranges="0.0.0.0/0" --target-tags="public"
2. gcloud compute firewall-rules create public-http --network=vke-network --allow="tcp:80" --source-ranges="0.0.0.0/0" --target-tags="public"
3. gcloud compute firewall-rules create private-ssh --network=vke-network --allow="tcp:22" --source-tags="public" --target-tags="private"
4. gcloud compute firewall-rules create internal-icmp --network=vke-network --allow="icmp" --source-tags="public,private"

#### create ssh key

1. gcloud compute config-ssh

#### create instances

1. gcloud compute instances create public-on-subnet-0 --machine-type=f1-micro --network=vke-network --subnet=subnet-0 --zone=us-east1-b --tags=public
2. gcloud compute instances create private-on-subnet-0 --machine-type=g1-small --network=vke-network --subnet=subnet-0 --zone=us-east1-b --tags=private
3. gcloud compute instances list

private-on-subnet-0 us-east1-b g1-small 172.16.1.3 35.196.251.89 RUNNING
public-on-subnet-0 us-east1-b f1-micro 172.16.1.2 35.231.204.182 RUNNING

#### add ssh key to instances

1. ssh 35.231.204.182 "sudo apt-get -y install nginx"
2.

#### load balancer

1. gcloud compute instance-groups unmanaged create http-ig-us-east --zone us-east1-b
2. gcloud compute instance-groups unmanaged create tomcat-ig-us-west --zone
   us-west1-a
   gcloud compute instance-groups unmanaged set-named-ports tomcat-ig-us-
   west --zone us-west1-a --named-ports tomcat:8080
   gcloud compute instance-groups unmanaged add-instances http-ig-us-west --
   instances public-on-subnet-a --zone us-west1-a

gcloud compute health-checks create http my-http-health-check --check-
interval 5 --healthy-threshold 2 --unhealthy-threshold 3 --timeout 5 --port
80 --request-path /

//create health check for Tomcat (8080/tcp) for "/examples/"
\$ gcloud compute health-checks create http my-tomcat-health-check --check-
interval 5 --healthy-threshold 2 --unhealthy-threshold 3 --timeout 5 --port
8080 --request-path /examples/

#### persistence disk

1. gcloud compute disks create vke-disk-us-east1-b --zone us-east1-b --type pd-standard --size 20
2. gcloud compute disks list

#### k8s cluster

1. gcloud container clusters create vke-k8s-cluster --machine-type f1-micro --num-nodes 3 --network vke-network --subnetwork subnet-0 --zone us-east1-b --tags private
2. gcloud container get-server-config
