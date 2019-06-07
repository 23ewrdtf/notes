The container block is used to signify that the steps inside the block should be run inside the container with the given label.
remove comments as the code below wont work otherwise.

```
pipeline {
  agent {
    kubernetes { //# use agent kubernetes
      label 'python' //# For example Python
      //# use below yaml to create a container https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/
      yaml """ 
apiVersion: v1
kind: Pod
metadata:
  labels:
    project: some_project //# name of a project
spec:
  containers:
  - name: python //# name of the container
    image: python:2.7-alpine3.6 //# image of the container
    command:
    //# https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/
"""
    }
  }
  environment {
    env1 = "example1" //# Environment variables if needed
  }
  stages {
    stage('descriptive name of the stage') { //# name of the stage
      when {
        branch "master" //# name of the branch in git
      }
      steps {
      	sendNotifications 'STARTED'
        container('python') { //# The container block is used to signify that the steps inside the block should be run inside the container with the given label.

          sh """
            python some commands //# command that will be run inside the container
            """
        }
      }
    }
  }
  post {
    always {
      sendNotifications currentBuild.currentResult
    }
  }
}
```
