#!/bin/bash
cd  /var/www/GeoOSM_Frontend/ && npx ng build
cp /var/www/GeoOSM_Frontend/htaccess.txt /var/www/GeoOSM_Frontend/dist/.htaccess
a2dissite 000-default.conf 
a2ensite vhost-admin.conf
a2ensite vhost-client.conf
service apache2 reload