#/bin/bash

cd /home/ubuntu
sudo apt update -y
sudo apt install git curl -y
cd /home/ubuntu
git clone https://github.com/sjh4616/target-ec2.git
sudo chown -R ubuntu:ubuntu target-ec2
cd target-ec2
chmod +x userdata.sh
./userdata.sh