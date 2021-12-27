FROM ubuntu:18.04
LABEL authors "BEN BAHRI Mohamed Taher"
LABEL authors.email "mrmedtb@gmail.com"
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Africa/Tunis

# Install Apache2
RUN apt update && \
    apt install -y apache2

### Install php 7.4
RUN apt update && \
    apt install -y software-properties-common tzdata wget curl

# add php repo
RUN add-apt-repository ppa:ondrej/php

# install php 7.4 & packages
RUN apt update && \
    apt install -y php7.4 && \
    apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath



# Ioncube loader
RUN curl -fSL 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \
    && mkdir -p ioncube \
    && tar -xf ioncube.tar.gz -C ioncube --strip-components=1 \
    && cp ioncube/ioncube_loader_lin_7.4.so /usr/lib/php/20190902/ \
    && rm -rf ioncube* \
    && echo "zend_extension = /usr/lib/php/20190902/ioncube_loader_lin_7.4.so" > /etc/php/7.4/cli/php.ini \
    && echo "zend_extension = /usr/lib/php/20190902/ioncube_loader_lin_7.4.so" > /etc/php/7.4/apache2/conf.d/00-ioncube.ini
    

EXPOSE 80
EXPOSE 443

CMD ["apachectl", "-D", "FOREGROUND"]
