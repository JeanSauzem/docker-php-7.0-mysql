FROM ubuntu:16.04

# Maintainer
MAINTAINER <Jean Sauzem> "<jean.marques@meta.com.br>"

ENV NGINX_VERSION 1.9.3-1~jessie

RUN apt-get update && apt-get install -y nginx php7.0 php7.0-fpm curl php7.0-bcmath php7.0-json php7.0-mbstring php7.0-mysql php7.0-pgsql && apt-get clean

# NGINX
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
VOLUME ["/var/cache/nginx"]
RUN rm /etc/nginx/sites-available/default
ADD ./default /etc/nginx/sites-available/default

# BUILD
WORKDIR /var/www/html

EXPOSE 80 443
CMD service php7.0-fpm start && nginx -g "daemon off;"