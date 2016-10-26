#!/bin/bash
cat <<EOT >> nginx.conf
user root;
events {
    worker_connections  4096;  ## Default: 1024
}
http {
    server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;
        return 301 https://\$host\$request_uri;
    }

    server {
        root `pwd`;
        listen 443 ssl;
        server_name localhost;
        ssl_certificate `pwd`/ssl/server.crt;
        ssl_certificate_key `pwd`/ssl/key.pem;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers HIGH:!aNULL:!MD5;
    }
}
EOT