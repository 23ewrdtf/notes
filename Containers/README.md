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

#### List namespaces from above cluster

`kubectl get ns`

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

