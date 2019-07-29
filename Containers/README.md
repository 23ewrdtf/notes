### Other

```
When we say AGE, we are referring time over the whole lifecycle of pod, not just in one phase.

An unschedulable pod will persist until a node shows up that can run it. That can result in a 1 day old pod getting scheduled to a 6 hour old node
```

```
https://discover.curve.app/a/mind-of-a-problem-solver

DNS Resolver resolves in some order:

domain.default.svc.cluster.local

domain.svc.cluster.local

domain.cluster.local

domain.eu-west-1.compute.internal

domain

The reason believes you used a short name. Add a dot at the end of your entry, for example: curl domain.com. This will tell the resolver that this is not a short name, it’s an absolute FQDN so we don’t need the search path. Just resolve it as it is.
```


### k8s in GCP

#### Enable APIs

```
# Set active project
gcloud set core/project <project_name>

# Enable APIs
gcloud services enable <APIs>

Usually:
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable sqladmin.googleapis.com
```

#### Delete default VPC and create a new one

```
# Set active project
gcloud config set core/project <project_name>

# List networks
gcloud compute networks list

# Delete default firewall rules
for FWRULE in $(gcloud compute firewall-rules list  --format='[no-heading](name)')
do
    if [[ $FWRULE == default-* ]] ; then
        echo delete default fw-rule $FWRULE
        gcloud compute firewall-rules delete $FWRULE --quiet
    fi
done

# Delete default networks
gcloud compute networks delete default --quiet

#Create a new network
gcloud compute networks create <vpc_name> --subnet-mode=custom
gcloud compute networks subnets create <vpc_name> --network=vpc<name> --range=<vpc_range> --region=<region>
```

#### Setup CloudSQL

```
# Set active project
gcloud config set core/project <project_name>
gcloud sql instances create <instance_name> --tier=<tier>  \
    --storage-type=<storage_type> \
    --storage-size=<storage_size> <storage_autoresize> \
    --database-version=<db_version> --region=<region> --gce-zone=<zone> \
    --backup --backup-start-time=<backup-start-time> --maintenance-window-day=<maintenance-window-day> \
    --maintenance-window-hour=<maintenance-window-hour> --maintenance-release-channel=<maintenance-release-channel>
    
# Set password    
gcloud sql users set-password <username> no-host --instance=<instance_name> \
       --password=<password>
```


#### Create k8s cluster https://cloud.google.com/sdk/gcloud/reference/container/clusters/create

```
gcloud container clusters create NAME --enable-ip-alias --enable-legacy-authorization --labels=[KEY=VALUE,…] --machine-type=MACHINE_TYPE --maintenance-window=TIME --network=VPC --node-labels=[NODE_LABEL,…] --num-nodes=NUM_NODES; default=3] --subnetwork=SUBNETWORK --enable-autoscaling --max-nodes=MAX_NODES --min-nodes=MIN_NODES --zone=<zone> --services-ipv4-cidr=CIDR --cluster-ipv4-cidr=CLUSTER_IPV4_CIDR
```

#### Before doing anything with k8s, set the context to work in

```
gcloud config set core/project <project_name>
gcloud config set compute/zone <zone>
gcloud config set compute/region <region>
gcloud config set container/cluster <cluster>
gcloud container clusters get-credentials <cluster>
```

### Other commands and stuff

#### List namespaces from above cluster

`kubectl get ns`

#### List pods on a namespace

`kubectl get pods -n <namespace>`

#### Create namespace on above cluster

`kubectl create namespace <namespace>`

#### Delete namespace on above cluster

`kubectl delete namespace <namespace>`

#### List SQL instances and store in cloudsql variable

`cloudsql=$(gcloud sql instances list --format='csv[no-heading](NAME, ADDRESS)') `

#### Create k8s deployment loadbalancer

`kubectl create -f loadbalancer.yaml`

#### loadbalancer.yaml

```
apiVersion: v1
kind: Service
metadata:
  labels:
    name: loadbalancer-name
  name: loadbalancer-name
spec:
  type: LoadBalancer
  ports:
    # The port that this service should serve on.
    - port: 443
      protocol: TCP
      name: https
  # Label keys and values that must match in order to receive traffic for this service.
  selector:
    app: nginx
```

#### Create a simple webserver.

Create a `Dockerfile` with below.

```
FROM nginx:alpine
COPY . /usr/share/nginx/html
```

This will Download `nginx:alpine`, copy current folder `.` into `/usr/share/nginx/html` and build an image called `test-image` with tag `v1`

```
docker build -t test-image:v1 .
```

List docker images.

```
docker images
```

Start image `test-image:v2` as a container and forward port 8080 locally to port 80 in the container.

```
docker run -d -p 8080:80 test-image:v2
```

Get events about specific pod

```
kubectl get event -n monitoring | grep POD_NAME
```

### Get pods per node

`kubectl get pods -o wide --all-namespaces | grep <YOUR-NODE>`

### Run a command in pod

`kubectl exec -it <POD NAME> -- ls /var/logs/`

### Get a shell inside a pod

`kubectl exec -it <POD NAME> -- /bin/bash`

#### Other examples, more here: https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/

```
root@shell-demo:/# ls /
root@shell-demo:/# cat /proc/mounts
root@shell-demo:/# cat /proc/1/maps
root@shell-demo:/# apt-get update
root@shell-demo:/# apt-get install -y tcpdump
root@shell-demo:/# tcpdump
root@shell-demo:/# apt-get install -y lsof
root@shell-demo:/# lsof
root@shell-demo:/# apt-get install -y procps
root@shell-demo:/# ps aux
root@shell-demo:/# ps aux | grep nginx
```

#### Decode secrets

```
printf $(kubectl get secret --namespace default <SECRET_NAME> -o jsonpath="{.data.<PATH TO SECRET>}" | base64 --decode);echo
```

#### Edit configMap

```kubectl edit configmap <cfg-name>``` This will open vi.

#### Replace configMap

```kubectl replace -f some_spec.yaml```

#### Save Nginx Ingress Controller config to a file

```
kubectl exec -it -n <NAMESPACE> internal-nginx-ingress-controller-<REST OF THE POD NAME> cat /etc/nginx/nginx.conf > internal-nginx-ingress-controller.conf
```

#### all pods on all nodes to csv (kind of)

`kubectl get pods --all-namespaces -o wide | tr -s ' ' ','`
