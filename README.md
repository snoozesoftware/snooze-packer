snooze-packer
=============

Templates for creating Snooze virtual machines base images

Usage
=====

```
git clone https://github.com/snoozesoftware/snooze-packer
cd snooze-packer
packer build <template name>
```

Templates
============

All the templates generate a virtual machine image with  : 

* login : snooze (in the sudoers)
* passwd : snooze
* sshd allow password connections.
* hadoop 1.2.1 preinstalled  (in the hadoop user home)
* network contextualization (see below)


Network contextualization
==========================

Ref : https://www.grid5000.fr/mediawiki/index.php/Virtual_machines_on_the_production_environment#Use_contextualization_to_configure_your_VMs

It works like the following :
* Test for the presence of a CD in the CD drive of the VM
* if it exists, mount the CD, test the presence of a script post-install, and run it as root
* if not use default parameters.


Grid'5000
========== 

The virtual machines can be used inside Grid'5000. 
In the libvirt template, make sure to give the mac address corresponding to an ip of your reserved subnet.
For instance : 

```
msimonin@fgrenoble:~$ g5k-subnets -im | more
10.132.8.1	00:16:3E:84:08:01
10.132.8.2	00:16:3E:84:08:02
10.132.8.3	00:16:3E:84:08:03

```
The mac address will be translated into ip during the contextualization process.

Requirements
=============

packer is required to generate the templates : http://www.packer.io/
