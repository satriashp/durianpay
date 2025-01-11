FROM nginx:alpine

RUN mkdir /var/www
COPY default.conf /etc/nginx/conf.d/
COPY hello.txt /var/www/

EXPOSE 80
