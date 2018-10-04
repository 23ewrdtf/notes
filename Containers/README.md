#### 


Create a `Dockerfile` with below.

```
FROM nginx:alpine
COPY . /usr/share/nginx/html
```

This will Download `nginx:alpine`, copy current folder `.` into `/usr/share/nginx/html` and build an image called `test-image` with tag `v1`

```
sudo docker build -t test-image:v1 .
```

List docker images.

```
docker images
```

Start image `test-image:v2` as a container and forward port 8080 locally to port 80 in the container.

```
sudo docker run -d -p 8080:80 test-image:v2
```
