#!/bin/bash

# this script will be run with sudo

# add use $HADOOP
HADOOP_USER=hadoop
HADOOP_GROUP=hadoop
HADOOP_VERSION=hadoop-1.2.1
TARBALL=$HADOOP_VERSION.tar.gz

echo "useradd $HADOOP_USER -s /bin/bash -m"
useradd $HADOOP_USER -s /bin/bash -m

# Move to the newly created directory
cd /home/$HADOOP_USER

# Generate keys
su hadoop -c "mkdir -p ~/.ssh"
su hadoop -c "ssh-keygen -N '' -f ~/.ssh/id_rsa"
su hadoop -c "cat ~/.ssh/id_rsa.pub > .ssh/authorized_keys"

# Install $HADOOP TARBALL
su hadoop -c "wget http://wwwftp.ciril.fr/pub/apache/hadoop/common/$HADOOP_VERSION/$TARBALL"
su hadoop -c "tar -xvzf $TARBALL"

# Install openjdk-7-jre
apt-get update && apt-get install -y openjdk-7-jre

#  Set java_hom in hadoop-env.sh
su hadoop -c "perl -pi -e  's,.*JAVA_HOME.*,export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre,g' /home/$HADOOP_USER/$HADOOP_VERSION/conf/hadoop-env.sh"



