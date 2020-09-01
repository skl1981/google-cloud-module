#!/bin/bash
# Installs nginx and enable
if [[ ! $(systemctl list-unit-files | grep nginx) ]]
    then sudo yum install nginx -y && sudo systemctl start nginx && sudo systemctl enable nginx
fi