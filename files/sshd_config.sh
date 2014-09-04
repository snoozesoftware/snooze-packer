#!/bin/bash

perl -pi -e "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" sshd_config
