#!/bin/bash

sudo apt update -y
sudo apt install -y docker.io openjdk-17-jdk git ruby wget zip unzip

cd /home/ubuntu

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

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

cat >/etc/init.d/codedeploy-start.sh <<EOF
#!/bin/bash
sudo service codedeploy-agent restart
EOF
sudo chmod +x /etc/init.d/codedeploy-start.sh

# docker 설치
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

# docker-compose 설치
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o \
 /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
