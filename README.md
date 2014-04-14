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

All the templates generate a virtual machine image with these parameters : 

* login : snooze (in the sudoers)
* passwd : snooze
* sshd allow password connections.
* hadoop 1.2.1 preinstalled  (in the hadoop user home)


Requirements
=============

packer is required to generate the templates : http://www.packer.io/
