FROM keopx/apache-php:7.3

RUN apt-get update && apt-get install -y \
    nano \
    sed  \
    curl \
    git \
    iproute2 \
    software-properties-common

RUN apt-add-repository --remove 'deb https://qgis.org/debian buster main'

RUN apt-add-repository 'deb https://qgis.org/debian buster main'

RUN wget -O - https://qgis.org/downloads/qgis-2019.gpg.key | gpg --import
RUN gpg --export --armor 51F523511C7028C3 | apt-key add -

RUN apt-get update && apt-get install -y \
    qgis \
    python3-qgis
    
RUN a2enmod proxy_http
RUN a2enmod headers
# RUN sed -i "s/PassEnv/#PassEnv/g" /etc/apache2/conf-available/qgis.conf 
# RUN service apache2 restart
RUN rm -rf /var/www/geosm/ || true
RUN mkdir /var/www/geosm/
RUN chmod -R 777 /var/www/geosm/

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs
RUN npm install -g forever

RUN rm -rf /home/keopx/backend_nodejs/ || true
WORKDIR /home/keopx/
RUN git clone https://github.com/GeoOSM/backend_nodejs
RUN cp /home/keopx/backend_nodejs/docker_geom_carto/boot_geosm_carto.sh /home/keopx/
WORKDIR /home/keopx/backend_nodejs/
RUN npm install

RUN ["chmod", "+x", "/home/keopx/boot_geosm_carto.sh"]

