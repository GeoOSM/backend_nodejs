#!/bin/bash

for s in $(cat "./new_project_config.json" | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" ); do
    export $s
done

geosm_nodejs_dir='./'
list_projet='./projet.json'

echo "====== Création et initialisation de la BD ======"
list_projet='./projet.json'
psql -c "DROP DATABASE $db"
psql -c "CREATE DATABASE $db"
echo "db created"
psql -d  $db -c "CREATE EXTENSION postgis"
psql -d $db -c "CREATE EXTENSION hstore"
#psql CREATE EXTENSION postgis_topology
echo "extention created"
pg_restore -U postgres -d $db  ./BD/template_bd.backup --verbose
wget $path_pbf -O osm.pbf
echo "====== Création et initialisation de la BD terminé ======"

echo "====== import termine et telechargement du osm.pbf ======"
osm2pgsql --slim -G -c -U postgres -d $db -H localhost -W --hstore-all -S ./BD/default.style osm.pbf
echo "====== import du osm.pbf termine ======"

colones=`psql -d $db  -c "select distinct(action) as key from sous_categorie"`

echo "====== CReation des index ======"

for col in $colones; do
    echo "Creation des index sur la colomne $col"
    psql -d $db  -c "CREATE INDEX planet_osm_point${col}_idx on planet_osm_point($col)"
    psql -d $db  -c "CREATE INDEX planet_osm_polygon${col}_idx on planet_osm_polygon($col)"
    psql -d $db  -c "CREATE INDEX planet_osm_line${col}_idx on planet_osm_line($col)"
done

echo "====== creation des index sur les colomnes terminées ======"


echo "====== IMPORT DE LA ZONE D'INTERET ======"

psql -d $db -c "DROP TABLE IF EXISTS temp_table;"
ogr2ogr -f "PostgreSQL" PG:"host=localhost user=$user_bd dbname=$db password=$pass_bd"  $roi -nln temp_table -nlt MULTIPOLYGON  -lco GEOMETRY_NAME=geom
psql -d $db -c "UPDATE instances_gc SET geom = ST_Buffer(st_transform(limite.geom ,4326)::geography,10)::geometry, true_geom = st_transform(limite.geom,4326) FROM (SELECT * from temp_table limit 1) as limite WHERE instances_gc.id = 1;"
psql -d $db -c "TRUNCATE temp_table;"

echo "====== IMPORT DE LA ZONE D'INTERET TERMINE ======"

echo "====== CREATION DES REPERTOIRE POUR QGIS SERVEUR (GPKG,STYLE) ======"

mkdir -m 777 -p $geosm_dir$db/gpkg/
mkdir -m 777 -p $geosm_dir$db/style/
mkdir -m 777 -p $geosm_dir/style/

echo "====== CREATION DES REPERTOIRE POUR QGIS SERVEUR TERMINE ======"

echo "====== TELECHARGEMENT DES STYLES PAR DEFAUT DE GEOSM ======"

rm -rf  ./backend_nodejs_temp
git clone https://github.com/GeoOSM/backend_nodejs/ ./backend_nodejs_temp
cp ./backend_nodejs_temp/python_script/style_default/*.qml $geosm_dir$db/style/
rm -rf  ./backend_nodejs_temp

echo "====== TELECHARGEMENT DES STYLES PAR DEFAUT DE GEOSM TERMINE ======"

echo "====== Telechargements des elements pour DOCKER ======"

rm -r $path_projet/docker/
mkdir -m 777 -p $path_projet/docker/
cp -r  $geosm_nodejs_dir/docker/ $path_projet/

mkdir -m 777 -p $path_projet/docker/public/upload
mkdir -m 777 -p $path_projet/docker/public/assets/images
mkdir -m 777 -p $path_projet/docker/public/assets/admin/images

mkdir -m 777 -p $path_projet/docker/client/

rm -rf  ./GeoOSM_Backend
git clone https://github.com/GeoOSM/GeoOSM_Backend/
mv ./GeoOSM_Backend/projet_laravel/.env.exemple $path_projet/docker/public/.env.exemple
mv ./GeoOSM_Backend/projet_laravel/public/assets/config_template.js $path_projet/docker/public/assets/config_template.js
mv ./GeoOSM_Backend/projet_laravel/public/assets/images $path_projet/docker/public/assets/
mv ./GeoOSM_Backend/projet_laravel/public/assets/admin/images $path_projet/docker/public/assets/admin/
rm -rf  ./GeoOSM_Backend

rm -rf  ./GeoOSM_Frontend
git clone -b dev https://github.com/GeoOSM/GeoOSM_Frontend/
mv ./GeoOSM_Frontend/src/assets/ $path_projet/docker/client/
mv ./GeoOSM_Frontend/src/environments/ $path_projet/docker/client/environments/
cp $path_projet/docker/client/environments/environment-exemple.ts $path_projet/docker/client/environments/environment.ts
sed -i "s+'path_qgis_value'+"'"'${geosm_dir}'"'"+g" $path_projet/docker/client/environments/environment.ts
sed -i "s/'pojet_nodejs_value'/"'"'${db}'"'"/g" $path_projet/docker/client/environments/environment.ts
chmod -R 755 $path_projet/docker/
rm -rf  ./GeoOSM_Frontend

cp $geosm_nodejs_dir/docker/htaccess.txt $path_projet/docker/client/htaccess.txt

echo "====== Telechargements des elements pour DOCKER TERMINE======"

echo "====== CONFIGURATION DES FICHIERS DE CONFIG DE NODE JS ET LARAVEL ======"

jq --arg path_backend $path_projet"/docker/" --arg db $db --arg user_bd $user_bd --arg pass_bd $pass_bd --arg port_bd $port_bd --arg destination_style $geosm_dir$db/style/ --arg destination $geosm_dir$db/gpkg/ '.projet[$db] = {"destination_style":$destination_style,"destination":$destination,"database":$db,"user":$user_bd,"password":$pass_bd,"port":$port_bd,"path_backend":$path_backend}'  ${list_projet} |sponge  ${list_projet}

echo "Fichier de configuration pour NODE js crée"

cp $path_projet"/docker/public/assets/config_template.js" $path_projet"/docker/public/assets/config.js" 

jq -n  --arg rootApp "/var/www/GeoOSM_Backend/projet_laravel/" --arg urlNodejs $urlNodejs_backend"importation" --arg urlNodejs_backend $urlNodejs_backend --arg projet_qgis_server $db '{"rootApp":$rootApp,"urlNodejs":$urlNodejs,"urlNodejs_backend":$urlNodejs_backend,"projet_qgis_server":$projet_qgis_server}' > $path_projet"/docker/public/assets/config.js"

sed  -i '1i var config_projet =' $path_projet"/docker/public/assets/config.js"

cp $path_projet"/docker/public/.env.exemple" $path_projet"/docker/public/.env"
sed -i 's/database_username/'${user_bd}'/g' $path_projet"/docker/public/.env"
sed -i 's/database_password/'${pass_bd}'/g' $path_projet"/docker/public/.env"
sed -i 's/database_name/'${db}'/g' $path_projet"/docker/public/.env"

echo "Fichier de configuration pour laravel crée"
echo "====== CONFIGURATION DES FICHIERS DE CONFIG DE NODE JS ET LARAVEL TERMINE ======"




echo "termne !!!!! !!! !"
exit


# sudo apt-get install php7.3-xml
# sudo apt-get install php-mbstring
#sudo apt-get install php7.3-zip
#sudo apt-get install python3-shapely
# sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
# sudo apt-get install gdal-bin
#mkdir -m 777 -p /var/www/geosm/style
#mkdir -m 777 -p /var/www/geosm/analyse
#apt-get install jq
#  apt-get install moreutils
#npm install -g github-files-fetcher
#npm install forever -g
#sudo a2enmod proxy_http
# sudo a2enmod rewrite

####### pour debian 10 #######
#vim /etc/apt/sources.list
# deb     https://qgis.org/debian buster main
# deb-src https://qgis.org/debian buster main

####### pour ubuntu 18 #######
#vim /etc/apt/sources.list
# deb     https://qgis.org/ubuntu bionic main
# deb-src https://qgis.org/ubuntu bionic main

# wget -O - https://qgis.org/downloads/qgis-2019.gpg.key | gpg --import
# gpg --fingerprint 51F523511C7028C3
# gpg --export --armor 51F523511C7028C3 | sudo apt-key add -
# sudo apt-get update
# apt install qgis-server
#apt install apache2 libapache2-mod-fcgid
#a2enmod fcgid
#apt-get install php7.2-gd

# mkdir /var/log/qgis/
# chown www-data:www-data /var/log/qgis
# mkdir /home/qgis/qgisserverdb
# chown www-data:www-data /home/qgis/qgisserverdb

# Donner le mot de passe postgres à l'utilisateur postgres dans la bd
#su postgres
#psql
#ALTER USER postgres WITH PASSWORD 'postgres';

#npm run initialiser_projet --projet=mali
#npm run apply_style_projet --projet=mali
#a2ensite la conf
#systemctl reload apache2

#étant root, si non il ecrira pas les log : forever start  -a --minUptime 5000  --spinSleepTime 5000 -l process.log -o out.log -e err.log server.js
# log de forver alors sont cat /root/.forever/process.log


#php artisan migrate

# 2a01:e0d:1:c:58bf
# @2a01:e0d:1:c:58bf:fac1:8000:167

# http://[2a01:e0d:1:c:58bf:fac1:8000:167]

# [2607:f0d0:1002:11::4:80] 
