A chart is organized as a collection of files inside of a directory. The directory name is the name of the chart.

```
mkdir ./hello-world
cd ./hello-world
```

A chart must include a chart definition file, Chart.yaml . Chart definition file must define two properties: name and version (Semantic Versioning 2).

```
cat <<'EOF' > ./Chart.yaml
name: hello-world
version: 1.0.0
EOF
```

A chart must define templates used to generate Kubernetes manifests, e.g.

```
$ mkdir ./templates
$ cat <<'EOF' > ./templates/deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: hello-world
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
        - name: hello-world
          image: gcr.io/google-samples/node-hello:1.0
          ports:
            - containerPort: 8080
              protocol: TCP
EOF
$ cat <<'EOF' > ./templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: hello-world
spec:
  type: NodePort
  ports:
  - port: 8080
    targetPort: 8080
    protocol: TCP
  selector:
    app: hello-world
EOF
```

That is all thats required to make a release.


Use `helm install RELATIVE_PATH_TO_CHART` to make a release.

```
helm install .
NAME:   cautious-shrimp
LAST DEPLOYED: Thu Jan  5 11:32:04 2017
NAMESPACE: default
STATUS: DEPLOYED
RESOURCES:
==> v1/Service
NAME          CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
hello-world   10.0.0.175   <nodes>       8080:31419/TCP   0s
==> extensions/Deployment
NAME          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-world   1         1         1            0           0s
```

`helm install .` used Kubernetes manifests in ./templates directory to create a deployment and a service:

Use `helm ls` to list deployed releases

Use `helm status RELEASE_NAME` to inspect a particular release

Use `helm delete RELEASE_NAME` to remove all Kubernetes resources associated with the release

Use `helm ls --deleted` to list deleted releases

Use `helm rollback RELEASE_NAME REVISION_NUMBER` to restore a deleted release

Use `helm delete --purge RELEASE_NAME` to remove all Kubernetes resources associated with with the release and all records about the release from the store.

```
helm delete --purge cautious-shrimp
helm ls --deleted
```

Helm Chart templates are written in the Go template language, with the addition of 50 or so add-on template functions from the Sprig library and a few other specialized functions.

Values for the templates are supplied using values.yaml file, e.g.

```
cat <<'EOF' > ./values.yaml
image:
  repository: gcr.io/google-samples/node-hello
  tag: '1.0'
EOF
```

Values that are supplied via a values.yaml file are accessible from the .Values object in a template.

```
cat <<'EOF' > ./templates/deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: hello-world
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
        - name: hello-world
          image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
          ports:
            - containerPort: 8080
              protocol: TCP
EOF
```


Values in the values.yaml can be overwritten at the time of making the release using --values YAML_FILE_PATH or --set key1=value1,key2=value2 parameters, e.g.

```
helm install --set image.tag='latest' .
```

Values provided using --values parameter are merged with values defined in values.yaml file and values provided using --set parameter are merged with the resulting values, i.e. --set overwrites provided values of --value, --value overwrites provided values of values.yaml .

Using templates to generate the manifests require to be able to preview the result. Use --dry-run --debug options to print the values and the resulting manifests without deploying the release:

Note, that it is your responsibility to ensure that all resources have a unique name and labels. In the above example, I am using .Release.Name and .Chart.Name to create a resource name.














