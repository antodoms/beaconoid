upstream unicorn {
  server unix:/tmp/unicorn.beaconoid.sock fail_timeout=0;
}

server {
  listen 80 default deferred;
  #listen 443;

  #ssl on;
  #ssl_certificate /home/ubuntu/certificate/beaconoid.me.cert.pem;
  #ssl_certificate_key /home/ubuntu/certificate/beaconoid.me.private.pem;

  server_name www.beaconoid.me;
  root /home/ubuntu/beaconoid/current/public;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  location ~ ^/(robots.txt|sitemap.xml.gz)/ {
    root /home/ubuntu/beaconoid/current/public;
  }
  location /cable {
    proxy_pass http://unicorn/cable;
    proxy_http_version 1.1;
    proxy_set_header Upgrade websocket;
    proxy_set_header Connection Upgrade;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
  }

  try_files $uri/index.html $uri @unicorn;
  location @unicorn {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://unicorn;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 4G;
  keepalive_timeout 10;
}