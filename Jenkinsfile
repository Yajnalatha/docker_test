def label = "mypod-${UUID.randomUUID().toString()}"

def serviceaccount = "jenkins-admin"

podTemplate(label: label, serviceAccount: serviceaccount, containers: [

    containerTemplate(name: 'kubectl', image: 'smesch/kubectl', ttyEnabled: true, command: 'cat',

                             volumes: [secretVolume(secretName: 'kube-config', mountPath: '/root/.kube')]),                            

    containerTemplate(name: 'docker', image: 'docker:1.11', ttyEnabled: true, command: 'cat'),

    containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', ttyEnabled: true, command: 'cat'),

    containerTemplate(name: 'jmeter', image: 'floodio/jmeter:5.0', ttyEnabled: true, command: 'cat'),

    containerTemplate(name: 'nmap', image: 'uzyexe/nmap', ttyEnabled: true, slaveConnectTimeout:300, command: 'cat'),

    containerTemplate(name: 'jnlp', image: 'jenkins/jnlp-slave:latest', args: '${computer.jnlpmac} ${computer.name}'),

    containerTemplate(name: 'zap', image: 'owasp/zap2docker-stable', privileged: true, ttyEnabled: true, command: '/bin/bash', workingDir: '/home/jenkins/' )],

    volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]

      ) {

 

     node(label) {

          def app

    container('docker')

    {

                  stage('Clone repository') {

        checkout scm

    }

 

    stage('Build image') {

     

        app = docker.build("yajnalatha/webapp")

    }

 

    stage('Push image') {

 

        docker.withRegistry('https://hub.docker.com/', 'docker-hub') {

            app.push("${env.BUILD_NUMBER}")

            app.push("latest")

        }

                               

                stage('run')

                {

                   sh 'docker rm -f web_con || true'

                   sh 'docker -d -p 8000:80 --name web_con webapp'

                }

    }

    }

}

}
