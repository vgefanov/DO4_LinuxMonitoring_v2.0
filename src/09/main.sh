#!/bin/bash

# sudo apt install nginx
sudo cp ./nginx/nginx.conf /etc/nginx/nginx.conf
sudo nginx -s reload
chmod +x my_nodes.sh
while sleep 3
do
    ./my_nodes.sh > ./nginx/metrics.html
done
