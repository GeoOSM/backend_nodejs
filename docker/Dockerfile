FROM keopx/apache-php:7.3
# Set working directory
WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev \
    php7.3-pgsql\
    dos2unix

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs

RUN rm -rf /var/www/GeoOSM_Backend/ || true
RUN git clone https://github.com/GeoOSM/GeoOSM_Backend 
RUN cd /var/www/GeoOSM_Backend/projet_laravel && composer install
RUN  chmod -R 777 /var/www/GeoOSM_Backend/projet_laravel


RUN rm -rf /var/www/GeoOSM_Frontend/ || true
RUN git clone -b dev https://github.com/GeoOSM/GeoOSM_Frontend
RUN cd /var/www/GeoOSM_Frontend/ && npm install

RUN rm -rf /var/www/backend_nodejs/ || true
RUN git clone https://github.com/GeoOSM/backend_nodejs
RUN cp /var/www/backend_nodejs/docker/boot.sh /var/www/
RUN rm -rf /var/www/backend_nodejs/ || true

RUN touch /var/www/GeoOSM_Backend/projet_laravel/.env
RUN touch /var/www/GeoOSM_Backend/projet_laravel/public/assets/config.js

RUN ["chmod", "+x", "/var/www/boot.sh"]