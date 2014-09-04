#!/bin/bash

# this script will be run with sudo

# add use $DMTCP
DMTCP_USER=work
DMTCP_GROUP=work
//cryp passwd
DMTCP_USER_PASSWD=dix3mC821HkgI
TARBALL=dmtcp.tar.gz
SOFTWARE_ROOT=/home/$DMTCP_USER/software
DMTCP_ROOT=$SOFTWARE_ROOT/dmtcp

echo "useradd $DMTCP_USER -s /bin/bash -m -p $DMTCP_USER_PASSWD"
useradd $DMTCP_USER -s /bin/bash -m

# allow passwordless passwd
echo "$DMTCP_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/work

# Move to the newly created directory
cd /home/$DMTCP_USER

# Generate keys
su work -c "mkdir -p ~/.ssh"
su work -c "ssh-keygen -N '' -f ~/.ssh/id_rsa"
su work -c "cat ~/.ssh/id_rsa.pub > .ssh/authorized_keys"

# Install $DMTCP TARBALL
su work -c "mkdir -p $SOFTWARE_ROOT"
su work -c "cd $SOFTWARE_ROOT && wget -L https://github.com/msimonin/dmtcp/tarball/hook_script -O dmtcp.tar.gz" 
tmp=$(su work -c "tar tf $SOFTWARE_ROOT/dmtcp.tar.gz | head -n 1")
distrib="${tmp%/}"
su work -c "cd $SOFTWARE_ROOT && tar -xvzf $TARBALL"
su work -c "cd $SOFTWARE_ROOT && mv ${distrib} dmtcp"


#### compilation of dmtcp
apt-get install -y g++ patch make
# make the program
su work -c "cd $DMTCP_ROOT && ./configure" 
su work -c "cd $DMTCP_ROOT && make"
cd $DMTCP_ROOT && make install
# make the tests
su work -c "cd $DMTCP_ROOT/test && make"

# Build the plugin
su work -c "cd $DMTCP_ROOT/contrib/script && gcc -shared -fPIC -I$DMTCP_ROOT/include -o script.so script.c"

# Extra dependencies 
apt-get install python-boto nfs-common

