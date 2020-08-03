#!/bin/bash
host=$(/sbin/ip route|awk '/default/ { print $3 }')

cp "/var/www/GeoOSM_Backend/projet_laravel/.env" "/var/www/GeoOSM_Backend/projet_laravel/.env_temp"
sed -i 's/localhost/'${host}'/g' "/var/www/GeoOSM_Backend/projet_laravel/.env_temp"
cp "/var/www/GeoOSM_Backend/projet_laravel/.env_temp" "/var/www/GeoOSM_Backend/projet_laravel/.env"

cd  /var/www/GeoOSM_Backend/projet_laravel/ && php artisan migrate && php artisan createAllTablesOSM && php artisan refresh:database_osm
cd  /var/www/GeoOSM_Frontend/ && npx ng build
cp /var/www/GeoOSM_Frontend/htaccess.txt /var/www/GeoOSM_Frontend/dist/.htaccess
a2dissite 000-default.conf 
a2ensite vhost-admin.conf
a2ensite vhost-client.conf
service apache2 reload
chmod -R 777 /var/www/GeoOSM_Backend/

