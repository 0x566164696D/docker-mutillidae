FROM alpine:latest
LABEL maintainer=0x566164696D

COPY dist/install_db.sh  /tmp/install_db.sh

RUN apk update && apk add \
        logrotate \
        supervisor \
        nginx \
        php \
        mariadb \
        pwgen \
        curl \
        wget \
        bash \
        unzip \
        php-fpm \
        php-mysqli \
        php-mbstring \
        php-session \
        php-simplexml \
        php-curl \
        php-json \
        php-ldap \
        --no-cache && \
    apk add --update tzdata && \
    adduser -H -D -g http http && \
    mkdir -p /usr/share/nginx/html /run/nginx /var/log/mysql && \
    wget -q https://github.com/webpwnized/mutillidae/archive/master.zip -O /tmp/mutillidae.zip && \
    unzip -q /tmp/mutillidae.zip -d /usr/share/nginx/html && \
    mv /usr/share/nginx/html/mutillidae* /usr/share/nginx/html/mutillidae &&\
    chown -R http:http /usr/share/nginx/html && \
    bash /tmp/install_db.sh && \
    sed -i 's/^error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_DEPRECATED/' /etc/php7/php.ini && \
    apk del \
      wget \
      unzip \
      pwgen && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ENV TZ=Europe/Moscow
COPY dist/nginx.conf /etc/nginx/nginx.conf
COPY dist/logrotate.conf /etc/logrotate.d/nginx
COPY dist/supervisord.ini /etc/supervisor.d/supervisord.ini
COPY dist/my.cnf /etc/my.cnf
COPY dist/php-fpm.conf /etc/php7/php-fpm.conf
COPY dist/index.html /usr/share/nginx/html/index.html

## you may set default security_level
#RUN sed -i "s/$_SESSION\['security-level'\] = '0';/$_SESSION\['security-level'\] = '5';/" /usr/share/nginx/html/mutillidae/index.php

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
