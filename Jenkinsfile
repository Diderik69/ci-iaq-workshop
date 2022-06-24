pipeline {
    agent any

    environment {
      HCLOUD_TOKEN = credentials('hcloud-token')
    }

    stages {
        stage('Start Test VM') {
            steps {
              dir('ci-test-vm') {
                sh 'terraform apply -auto-approve -var="hcloud_token=${HCLOUD_TOKEN}"'
                // hier soll die VM gestartet werden
              }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
              sh ' ansible-playbook -i inventory/test.hcloud.yml installhero-app.yml'
              // hier sollen die Playbooks laufen
            }
        }
    }
    post {
        always {
          dir('terraform destroy -auto-approve
-var="hcloud_token=${HCLOUD_TOKEN}"') {
  
             // hier soll die VM gelöscht werden
          }
         }
    }
}
