#!/bin/bash

yum -y update
yum -y install httpd.x86_64
systemctl enable httpd.service
systemctl start httpd.service
echo "Hello from $(hostname -f)" >> /var/www/html/index.html
