#!/bin/bash

docker rm nginx -f
docker run -d \
  --name nginx \
  --network=host \
  --restart=always \
  -v=/opt/nginx-lb/nginx.conf:/etc/nginx/nginx.conf \
  -v=/opt/nginx-lb/default.conf:/etc/nginx/conf.d/default.conf \
  -v=/opt/nginx-lb/apiserver.conf:/etc/nginx/conf.d/apiserver.conf \
  -v=/opt/nginx-lb/stream-services.conf:/etc/nginx/conf.d/stream-services.conf \
  -v=/opt/nginx-lb/ingress-nginx.conf:/etc/nginx/conf.d/ingress-nginx.conf \
  -v=/opt/nginx-lb/ingress-traefik.conf:/etc/nginx/conf.d/ingress-traefik.conf \
  nginx
