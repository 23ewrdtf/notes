### Most basic pipeline with user choice

```
@Library('bitwiseman-shared') _ 

pipeline {
    agent any

  
    parameters {
      choice(name: 'SERVICE', choices: ['Service1', 'Service2', 'Service3', 'Service4', 'Service5'], description: 'service')
    }

stages {
        stage("Stage1") {
            steps {
              echo 'Hello Stage1'
            }
        }
        stage("Stage2") {
         steps {
              echo 'Hello Stage2'
         }
        }
    }
  }
```  
 
### Most basic pipeline with Users choice and IF statement

```
@Library('bitwiseman-shared') _ 

pipeline {
    agent any

  
    parameters {
      choice(name: 'SERVICE', choices: ['Service1', 'Service2', 'Service3', 'Service4', 'Service5'], description: 'service')
    }
  stages {
      stage('Stage 1') {
          steps {
              echo "Stage1"

                script {
                    if (env.SERVICE == 'Service1') {
                        echo 'You selected Service1'
                    } else {
                        echo 'You selected Some other service'
                    }
                }

          }
      }

    stage('Stage 2') {
        steps {
              echo "Stage2"
        }
    }

    stage('Stage 3') {
      steps {
              echo "Stage3"
      }
    }

    stage ('Stage 4') {
      steps {
              echo "Stage4"
      }
    }
  }
}
```
 
### Most basic pipeline with Users choice and IF statement and setting up a variable.

```
@Library('bitwiseman-shared') _ 

pipeline {
    agent any

  
    parameters {
      choice(name: 'SERVICE', choices: ['Service1', 'Service2', 'Service3', 'Service4', 'Service5'], description: 'service')
    }
  stages {
      stage('Stage 1') {
          steps {
              echo "Stage1"

                script {
                    if (env.SERVICE == 'Service1') {
                        echo 'You selected Service1'
                    } else {
                        echo 'You selected Some other service'
                    }
                }

          }
      }

    stage('Stage 2') {
        steps {
              echo "Stage2"

                script {
                    if (env.SERVICE == 'Service1') {
                        env.SERVICE_ID = 'Service1_ID'
                        echo "Service ID is ${env.SERVICE_ID}"
                    } else {
                        echo 'You selected Some other service'
                    }
                }
        }
    }

    stage('Stage 3') {
      steps {
              echo "Stage3"
      }
    }

    stage ('Stage 4') {
      steps {
              echo "Stage4"
      }
    }
  }
}
```

### Most basic pipeline with Users choice and multiple IF statements and setting up a variable.

```
@Library('bitwiseman-shared') _ 

pipeline {
    agent any

  
    parameters {
      choice(name: 'SERVICE', choices: ['Service1', 'Service2', 'Service3', 'Service4', 'Service5'], description: 'service')
    }
  stages {
      stage('Stage 1') {
          steps {
              echo "This is Stage 1"

                script {
                    if (env.SERVICE == 'Service1') {
                        echo 'You selected Service1'
                    } else {
                        echo 'You selected Some other service'
                    }
                }

          }
      }

    stage('Stage 2') {
        steps {
              echo "This is Stage 2"

                script {
                    if (env.SERVICE == 'Service1') {env.SERVICE_ID = 'Service1_ID'} 
                    if (env.SERVICE == 'Service2') {env.SERVICE_ID = 'Service2_ID'} 
                    if (env.SERVICE == 'Service3') {env.SERVICE_ID = 'Service3_ID'} 
                    if (env.SERVICE == 'Service4') {env.SERVICE_ID = 'Service4_ID'} 
                    if (env.SERVICE == 'Service5') {env.SERVICE_ID = 'Service5_ID'} 
                        echo "Service is ${env.SERVICE}"
                        echo "Service ID is ${env.SERVICE_ID}"
                        
                        // Here goes some script you want to run 
                        // For example:
                        // container('docker') {
                        //  sh """            
                        //      some bash command with ${env.SERVICE_ID}
                        //  """
                        //  }
        
                }
        }
    }

    stage('Stage 3') {
      steps {
              echo "This is Stage 3"
      }
    }

    stage ('Stage 4') {
      steps {
              echo "This is Stage 4"
      }
    }
  }
}
```

### Most basic pipeline with Users choice and MAP statements and setting up a variable.

```
@Library('bitwiseman-shared') _ 

pipeline {
    agent any

  
    parameters {
      choice(name: 'SERVICE', choices: ['Service1', 'Service2', 'Service3', 'Service4', 'Service5'], description: 'service')
    }
  stages {
      stage('Stage 1') {
          steps {
              echo "This is Stage 1"

                script {
                    if (env.SERVICE == 'Service1') {
                        echo 'You selected Service1'
                    } else {
                        echo 'You selected Some other service'
                    }
                }

          }
      }

    stage('Stage 2') {
        steps {
              echo "This is Stage 2"

                script {
                    def api_map = [
                        'ami': 'ami', 
                        'Service1': 'Service1_ID', 
                        'Service2': 'Service2_ID', 
                        'Service3': 'Service3_ID',
                        'Service4': 'Service4_ID',
                        'Service5': 'Service5_ID'
                    ]
                    env.SERVICE_ID = api_map.get(env.SERVICE)

                        echo "Service is ${env.SERVICE}"
                        echo "Service ID is ${env.SERVICE_ID}"                        
                        // Here goes some script you want to run 
                        // For example:
                        // container('docker') {
                        //  sh """            
                        //      some bash command with ${env.SERVICE_ID}
                        //  """
                        //  }
        
                }
        }
    }

    stage('Stage 3') {
      steps {
              echo "This is Stage 3"
      }
    }

    stage ('Stage 4') {
      steps {
              echo "This is Stage 4"
      }
    }
  }
}
```



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
