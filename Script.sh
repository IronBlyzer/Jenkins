
#!/bin/bash

sudo apt update

sudo apt install openjdk-17-jre

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install fontconfig openjdk-17-jre

sudo apt-get install jenkins

sudo service jenkins start

sleep 30


jenkins_password=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

sudo systemctl restart jenkins

echo "L'installation de Jenkins est terminée."
echo "Le mot de passe initial pour Jenkins est: $jenkins_password"
    