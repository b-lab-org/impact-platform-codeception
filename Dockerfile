FROM debian:jessie
MAINTAINER "The Impact Bot" <technology@bcorporation.net>

WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y \
    git \
    php5 \
    php5-fpm \
    php5-curl \
    php5-gd \
    php5-geoip \
    php5-imagick \
    php5-imap \
    php5-json \
    php5-ldap \
    php5-mcrypt \
    php5-mongo \
    php5-mysqlnd \
    php5-pgsql \
    php5-redis \
    php5-sqlite \
    php5-xdebug \
    php5-memcached \
    php5-dev \
    postgresql-9.4 \
    postgresql-contrib-9.4

RUN php5enmod mcrypt

# Igbinary and SASL authentication
RUN git clone https://github.com/phadej/igbinary.git && \
    cd igbinary && \
    phpize && \
    ./configure CFLAGS="-O2 -g" --enable-igbinary && \
    make && \
    make install && \
    cd .. && \
    rm -fr igbinary && \
    echo "xdebug.max_nesting_level=300" >> /etc/php5/cli/php.ini && \
    echo "memcached.use_sasl=1" >> /etc/php5/cli/php.ini && \
    echo "extension=igbinary.so" >> /etc/php5/mods-available/igbinary.ini && \
    echo "igbinary.compact_strings=Off" >> /etc/php5/mods-available/igbinary.ini && \
    php5enmod igbinary

RUN mkdir -p /data/www
VOLUME ["/data"]
WORKDIR /data/www

ENTRYPOINT ["php", "vendor/bin/codecept"]
