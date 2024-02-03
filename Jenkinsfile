pipeline {
    agent {
        node {
            label 'Agent'
        }
    }

    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'version', defaultValue: '', description: 'What is the artifact version?')
        string(name: 'environment', defaultValue: 'dev', description: 'What is environment?')
    }
    // build
    stages {
        stage('Print version') {
            steps {
                sh """
                    echo "version: ${params.version}"
                    echo "environment: ${params.environment}"
                """
            }
        }

        stage('Init') {
            steps {
                sh """
                    cd Terraform_tfvars
                    terraform init --backend-config=${params.environment}/backend.tf -reconfigure
                """
            }
        }

        stage('Plan') {
            steps {
                sh """
                    cd Terraform_tfvars
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}"
                """
            }
        }

        stage('Apply') {
            steps {
                sh """
                    cd Terraform_tfvars
                    terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }
        
    }
    // post build
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        failure { 
            echo 'this runs when pipeline is failed, used generally to send some alerts'
        }
        success{
            echo 'I will say Hello when pipeline is success'
        }
    }
}

//Run the below commnads in Terrafrom_tfvars folder to destroy
//terraform init -reconfigure -backend-config=dev/backend.tf
//terraform destroy -var-file=dev/dev.tfvars -var=app_version=1.0.0 -auto-approve
