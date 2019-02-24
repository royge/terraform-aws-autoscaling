#!/bin/bash -v
sudo apt-get update -y
sudo apt-get install -y nginx > /tmp/nginx.log
sudo echo "Hello Terraform!" > /var/www/html/index.html
sudo service nginx start
