pipeline{
    //Directivesasd
    agent any
    tools {
        maven 'maven'
    }

    stages {
        // Specify various stage with in stages

        // stage 1. Build
        stage ('Build'){
            steps {
                sh 'mvn clean install package'
            }
        }

        // Stage2 : Testing
        stage ('Test'){
            steps {
                echo ' testing......'

            }
        }
        // Stage3: Publish to nexus
        stage ("Publish to Nexus"){
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'MyLab', classifier: '', file: 'target/MyLab-0.0.4-Snapshot.war', type: 'war']], credentialsId: 'e3c08fb5-e259-4985-82b1-136ad0802892', groupId: 'com.mylab', nexusUrl: '172.20.10.53:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'MyLab-Snapshot', version: '0.0.4-Snapshot'
            }
        }



        // Stage3 : Publish the source code to Sonarqube
        stage ('Sonarqube Analysis'){
            steps {
                echo 'deploying......'
                // withSonarQubeEnv('sonarqube'){ // You can override the credential to be used
                //      sh 'mvn sonar:sonar'
                

            }
        }

        
        
    }

}