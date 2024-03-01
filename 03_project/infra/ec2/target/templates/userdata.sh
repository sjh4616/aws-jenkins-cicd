#!/bin/bash

sudo apt update -y
sudo apt install -y docker.io openjdk-17-jdk git ruby wget unzip

cd /home/ubuntu

# JAVA_HOME 설정
echo 'export JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"' >> ./.bashrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> ./.bashrc
source ./.bashrc

# codedeploy-agent 설치
wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
chmod u+x ./install
sudo ./install auto
sudo service codedeploy-agent status
rm -rf ./install

cat >/etc/init.d/codedeploy-start.sh <<EOL
#!/bin/bash
sudo service codedeploy-agent restart
EOL
sudo chmod +x /etc/init.d/codedeploy-start.sh

# docker 설치
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker