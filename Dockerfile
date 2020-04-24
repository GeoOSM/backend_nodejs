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

RUN rm -r /var/www/GeoOSM_Backend/ || true
RUN git clone https://github.com/GeoOSM/GeoOSM_Backend 
RUN cd /var/www/GeoOSM_Backend/projet_laravel && composer install
RUN  chmod -R 777 /var/www/GeoOSM_Backend/projet_laravel

RUN rm -r /var/www/GeoOSM_Frontend/ || true
RUN git clone -b dev https://github.com/GeoOSM/GeoOSM_Frontend
RUN cd /var/www/GeoOSM_Frontend/ && npm install

RUN ["chmod", "+x", "/var/www/boot.sh"]
# docker run -P backend_partie /bin/sh -c 'cd /var/www/GeoOSM_Backend/projet_laravel; php artisan route:list'
#  docker  run -w /var/www/GeoOSM_Backend/projet_laravel  -i -t  keopx/apache-php:7.3  php artisan route:list

#  docker  run -w /var/www/GeoOSM_Frontend/ -v "C:\Users\Utilisateur\Desktop\STAGE KARL\dev web\GeOSM\GeoOSM_Frontend\src\environments\environment.ts:/var/www/GeoOSM_Frontend/src/environments/environment.ts" -i -t  keopx/apache-php:7.3 ls npx ng build
#  



# docker-compose up -d
# docker  exec -w /var/www/GeoOSM_Frontend/ -i -t  backend_partie  npx ng build