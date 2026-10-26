pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'uat'], description: 'Environment to plan/apply')
        booleanParam(name: 'RUN_APPLY', defaultValue: false, description: 'Apply the saved plan after approval')
    }

    environment {
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Terraform Format') {
            steps { sh 'terraform fmt -check -recursive' }
        }

        stage('Terraform Init') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh '''
                        set -eu
                        terraform plan -input=false                           -var-file="terraform-${ENVIRONMENT}.tfvars"                           -out=tfplan
                        terraform show tfplan
                    '''
                }
            }
        }

        stage('Approval') {
            when {
                allOf {
                    branch 'main'
                    expression { params.RUN_APPLY }
                }
            }
            steps {
                input message: "Approve Terraform apply for ${params.ENVIRONMENT}?",
                      ok: 'Approve Apply'
            }
        }

        stage('Terraform Apply') {
            when {
                allOf {
                    branch 'main'
                    expression { params.RUN_APPLY }
                }
            }
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        success { echo 'Terraform pipeline completed successfully.' }
        failure { echo 'Terraform pipeline failed. Review console output.' }
        always { echo 'Pipeline finished.' }
    }
}
