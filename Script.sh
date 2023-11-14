#!/bin/bash

sudo apt update

sudo apt install -y openjdk-17-jre

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install -y fontconfig openjdk-17-jre

sudo apt-get install -y jenkins

sudo systemctl start jenkins

sleep 30

jenkins_password=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

wget http://localhost:8080/jnlpJars/jenkins-cli.jar

sleep 30

java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$jenkins_password groovy = <<EOF
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def user = hudsonRealm.createAccount('$1', '$2')
instance.setSecurityRealm(hudsonRealm)
instance.save()
EOF

sudo systemctl restart jenkins

echo "L'installation de Jenkins est terminée."
echo "Le mot de passe initial pour Jenkins est: $jenkins_password"
echo "Le nouveau utilisateur créé a - Nom utilisateur: $1, Mot de passe: $2"