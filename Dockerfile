FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    build-essential \
    default-mysql-client \
    libpng-dev \
    libonig-dev \
    libjpeg62-turbo-dev \
    libzip-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

USER root

ENV PUID 1000
ENV PGID 1000

RUN groupmod -o -g 1000 www-data && \
    usermod -o -u 1000 -g www-data www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
