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
                script{
                def NexusRepo = Version.endsWith("SNAPSHOT") ? "MyLab-Snapshot" : "MyLab-Release"
                
                nexusArtifactUploader artifacts: 
                [[artifactId: "${ArtifactID}",
                classifier: '',
                file: "target/${Name}-${Version}.war",
                type: 'war']],
                credentialsId: 'e3c08fb5-e259-4985-82b1-136ad0802892', 
                groupId: "${GroupId}", 
                nexusUrl: '172.20.10.53:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: "${NexusRepo}", 
                version: "${Version}"
                }
            }

        }

        // Stage4: To Print Inforamtion
        stage ('Print Environment Variables'){
            steps {
                echo  "Artefact ID: '${ArtifactID}'"
                echo  "Version: '${Version}'"
                echo  "GroupId: '${GroupId}'"
                echo  "Name: '${Name}'"

            }
        }


        // Stage5 : Publish the source code to Sonarqube
        stage ('Deploy'){
            steps {
                echo "Deploying..."
                sshPublisher(publishers: 
                [sshPublisherDesc(
                    configName: 'Ansible', 
                    transfers: [
                        sshTransfer(
                            cleanRemote: false, 
                            execCommand: 'ansible-playbook /opt/playbooks/downloadanddeploy_as_tomcat.yaml -i /opt/playbooks/hosts', 
                            execTimeout: 120000
                        )
                    ], 
                    usePromotionTimestamp: false, 
                    useWorkspaceInPromotion: false, 
                    verbose: false)
                    ])
                // withSonarQubeEnv('sonarqube'){ // You can override the credential to be used
                //      sh 'mvn sonar:sonar'
                

            }
        }

        // Stage5 : Publish the source code to Sonarqube
        stage ('Deploy to Docker'){
            steps {
                echo "Deploying..."
                sshPublisher(publishers: 
                [sshPublisherDesc(
                    configName: 'Ansible', 
                    transfers: [
                        sshTransfer(
                            cleanRemote: false, 
                            execCommand: 'ansible-playbook /opt/playbooks/downloadanddeploy_docker.yaml -i /opt/playbooks/hosts', 
                            execTimeout: 120000
                        )
                    ], 
                    usePromotionTimestamp: false, 
                    useWorkspaceInPromotion: false, 
                    verbose: false)
                    ])
                // withSonarQubeEnv('sonarqube'){ // You can override the credential to be used
                //      sh 'mvn sonar:sonar'
                

            }
        }
        
    }

}