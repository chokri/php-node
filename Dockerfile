FROM ubuntu:18.04

# Is my case I use UTF-8 👷
RUN export LC_ALL=C.UTF-8
# this disable front interactivity
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# ⚙️  Here we can udate all sys packages that we need
RUN apt-get update
RUN apt-get install -yqq \
    sudo \
    autoconf \
    autogen \
    language-pack-en-base \
    wget \
    curl \
    rsync \
    ssh \
    openssh-client \
    git \
    build-essential \
    apt-utils \
    software-properties-common \
    nasm \
    libjpeg-dev \
    libpng-dev \
    libpng16-16 \
    zip

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo    

# ⚡️ All I need to test my PHP Frameworks (CakePHP & Symfony)
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y php7.2
RUN apt-get install -yqq \
    php7.2-curl \
    php7.2-gd \
    php7.2-dev \
    php7.2-xml \
    php7.2-bcmath \
    php7.2-mysql \
    php7.2-mbstring \
    php7.2-zip \
    php7.2-bz2 \
    php7.2-sqlite \
    php7.2-soap \
    php7.2-json \
    php7.2-intl \
    php7.2-imap \
    php7.2-imagick \
    php-xdebug \
    php-memcached
RUN command -v php

# ⚡️ Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update --preview
RUN command -v composer

# ⚡️ PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit
RUN command -v phpunit

# ⚡️ Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@6.4.0 -g
RUN command -v node
RUN command -v npm


