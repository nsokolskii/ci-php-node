FROM ubuntu:20.04

ENV TZ=UTC

RUN export LC_ALL=C.UTF-8
RUN DEBIAN_FRONTEND=noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y \
    sudo \
    autoconf \
    autogen \
    language-pack-en-base \
    wget \
    zip \
    unzip \
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
    libpng16-16

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# PHP
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y php7.4
RUN apt-get install -y \
    php7.4-curl \
    php7.4-gd \
    php7.4-dev \
    php7.4-xml \
    php7.4-bcmath \
    php7.4-mysql \
    php7.4-pgsql \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-bz2 \
    php7.4-sqlite \
    php7.4-soap \
    php7.4-json \
    php7.4-intl \
    php7.4-imap \
    php7.4-imagick \
    php-memcached
RUN command -v php

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update
RUN command -v composer

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@6 -g
RUN command -v node
RUN command -v npm

# Other
RUN mkdir ~/.ssh
RUN touch ~/.ssh/config

# Git
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt-get update -y
RUN apt-get install git -y

# Display versions installed
RUN php -v
RUN composer --version
RUN node -v
RUN npm -v
RUN git --version
