#!/bin/bash
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key \
  -out /etc/nginx/ssl/nginx.crt \
  -subj "/C=RU/ST=Murmansk/L=Kola/O=Test/CN=localhost"
sudo nginx -t && sudo systemctl reload nginx
