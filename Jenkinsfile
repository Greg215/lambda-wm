#!/usr/bin/env groovy

//notification message send to the slack
def notify_channel_wm = "#tmp-wm"

def terraform_version = "1.0.11"
env.agent_label = "jenkins-vg-agent"

def terraform_output() {
    return sh (returnStdout: true,
            script: """terraform output"""
    ).trim()
}

if (currentBuild.getPreviousBuild()) {
    env.PREVIOUS_BUILD_RESULT = currentBuild.getPreviousBuild().getResult()
    echo "PREVIOUS BUILD RESULT: ${env.PREVIOUS_BUILD_RESULT}"
} else {
    env.PREVIOUS_BUILD_RESULT = "NONE"
}

def build_info = "Job: ${env.JOB_NAME}, Build: #${env.BUILD_NUMBER}."

properties([parameters([
        choice(choices: ["create", "remove"].join("\n"), description: "Create/Update or remove Lambda function", name: "terraform_action"),
])])

podTemplate(label: env.agent_label, yaml: """
apiVersion: v1
kind: Pod
metadata:
  name: "jenkins-vg-agent"
  labels:
    app: jenkins-vg-agent
spec:
  containers:
  - name: jenkins-agent
    image: "hashicorp/terraform:${terraform_version}"
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  nodeSelector:
        beta.kubernetes.io/instance-type: "t3.medium"
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
) {
    node(env.agent_label) {
        withAWS(credentials: 'aws-secret-key', region: 'ap-southeast-1') {
            stage('Notify') {
                slackSend channel: "${notify_channel_wm}", color: "warning", message: "Start terraform job for Lambda-wm  ${build_info} (<${env.BUILD_URL}|see details>)"
            }

            container('jenkins-agent') {
                    stage('Checkout') {
                        checkout scm
                    }

                    stage('Terraform Init') {
                        ansiColor('xterm') {
                            sh 'terraform init -input=false'
                        }
                    }

                    stage('Terraform Validate') {
                        ansiColor('xterm') {
                            sh 'terraform validate'
                        }
                    }

                    stage('Terraform Fmt') {
                        ansiColor('xterm') {
                            sh 'terraform fmt'
                        }
                    }

                    stage('Terraform Plan') {
                        ansiColor('xterm') {
                            sh 'terraform plan -out=tfplan -input=false'
                        }
                    }

                    try {
                        stage('Terraform Apply') {
                            ansiColor('xterm') {
                                if (env.terraform_action == "create") {
                                    sh 'terraform apply -input=false tfplan'
                                } else {
                                    echo "Skip Apply due to not match."
                                }
                            }
                        }
                    } catch (e) {
                        stage('Remove the failed Terraform apply') {
                            ansiColor('xterm') {
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }

                    stage('Terraform Output') {
                        ansiColor('xterm') {
                            if (env.terraform_action == "create") {
                                env.t_output = terraform_output()
                                echo "${env.t_output}"
                                slackSend channel: "${notify_channel_wm}", color: "good", message: "Created or updated Lambda-wm Info: ${env.t_output}"
                            } else {
                                echo "Skip Apply due to not match."
                            }
                        }
                    }

                    try {
                        stage('Terraform Destroy') {
                            ansiColor('xterm') {
                                if (env.terraform_action == "remove") {
                                    sh 'terraform destroy -auto-approve'
                                } else {
                                    echo "Skip Destroy due to not match."
                                }
                            }
                        }
                    } catch (e) {
                        try {
                            stage('Rerun failed Terraform destroy') {
                                ansiColor('xterm') {
                                    sh 'terraform destroy -auto-approve'
                                }
                            }
                        } catch (error) {
                            slackSend channel: "${notify_channel_wm}", color: "good", message: "Failed to remove the Lambda function even after the retry."
                        }
                    }

                    stage('Notify') {
                        slackSend channel: "${notify_channel_wm}", color: "good", message: "Lambda-wm has been ${env.terraform_action}"
                    }
            }
        }
    }
}