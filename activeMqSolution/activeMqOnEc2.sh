#!/bin/bash
# Please change as per system

USER=ec2-user

echo -n "*********** Downloading nessecary pathches  ************\n"

sudo yum install git wget httpd -y
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum update -y

#sudo apt-get install openjdk-8-jdk -y

echo -n "*********** Installation complete  ************\n"

echo -n "*********** Configuring activeMq  ************\n"
sleep 2
sudo mkdir -p /opt/activemqd

wget https://archive.apache.org/dist/activemq/5.15.6/apache-activemq-5.15.6-bin.tar.gz

tar -xvf apache-activemq-5.15.6-bin.tar.gz

mv apache-activemq-5.15.6-bin activemq 

sudo cp -rf activemq /opt/activemqd/ 

sudo chown -R $USER:$USER /opt/activemqd

echo -n "\n*********** activeMq configured  ************\n"



#sudo cp /opt/activemqd/bin/env /etc/default/activemq
#sudo sed -i '~s/^ACTIVEMQ_HOME="<Installationdir>/"/ACTIVEMQ_HOME="/opt/apachemqd/"/' /etc/default/activemq
#sudo sed -i '~s/^ACTIVEMQ_USER=""/ACTIVEMQ_USER="$USER"/' /etc/default/activemq

#sudo cp /opt/apachemqd/bin/activemq  /etc/init.d/activemq

#sudo chkconfig --add activemq
#sudo chkconfig activemq on
#sudo chkconfig -list

