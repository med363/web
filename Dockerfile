FROM ubuntu
LABEL maintainer=blibechmedamine@gmail.com
RUN apt-get update
RUN DEBIAN_FRONTEND=moninteractive apt-get install -y nginx git
EXPOSE 80
#ADD static-website-example/ /var/www/html/
RUN rm -rf /var/www/html/*
RUN git clone https://github.com/diranetafen/static-website-example.git  /var/www/html/
ENTRYPOINT ["/usr/sbin/nginx","-g","daemon off;"]
