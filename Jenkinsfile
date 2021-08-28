pipeline{
    //Directivesasd
    agent any
    tools {
        maven 'maven'
    }

    environment {
        ArtifactId = readMavenPom().getArtifactId()
        Version = readMavenPom().getVersion()
        Name = readMavenPom().getName()
        GroupId = readMavenPom().getGroupId()
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
                nexusArtifactUploader artifacts: [[artifactId: '${ArtifactID}', classifier: '', file: '${Name}-${Version}', type: 'war']], credentialsId: 'e3c08fb5-e259-4985-82b1-136ad0802892', groupId: '${GroupId}', nexusUrl: '172.20.10.53:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'MyLab-Snapshot', version: '${Version}'
            }
        }

        // Stage3: To Print Inforamtion
        stage ('Print Environment Variables'){
            steps {
                echo  "Artefact ID: '${ArtifactID}'"
                echo  "Version: '${Version}'"
                echo  "GroupId: '${GroupId}'"
                echo  "Name: '${Name}'"

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