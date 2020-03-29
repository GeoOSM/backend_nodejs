#!/bin/bash
db="mali"
roi="/var/www/GeoOSM_Backend/mali.shp"
path_pbf="http://download.geofabrik.de/africa/mali-latest.osm.pbf"
geosm_dir='/var/www/geosm/'
urlNodejs_backend='http://servicetest.geocameroun.xyz/'
path_backend="/var/www/GeoOSM_Backend/projet_laravel/"
user_bd='postgres'
pass_bd='postgres237'
port_bd=5432

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
echo "import termine et telechargement du osm.pbf"
osm2pgsql --slim -G -c -U postgres -d $db -H localhost -W --hstore-all -S ./BD/default.style osm.pbf
echo "import du osm.pbf termine"
psql -d $db -c "DROP TABLE IF EXISTS temp_table;"
ogr2ogr -f "PostgreSQL" PG:"host=localhost user=$user_bd dbname=$db password=$pass_bd"  $roi -nln temp_table -nlt MULTIPOLYGON  -lco GEOMETRY_NAME=geom
psql -d $db -c "UPDATE instances_gc SET geom = ST_Buffer(st_transform(limite.geom ,4326)::geography,10)::geometry, true_geom = st_transform(limite.geom,4326) FROM (SELECT * from temp_table limit 1) as limite WHERE instances_gc.id = 1;"
psql -d $db -c "TRUNCATE temp_table;"

mkdir -m 777 -p $geosm_dir$db/gpkg/
mkdir -m 777 -p $geosm_dir$db/style/
mkdir -m 777 -p $geosm_dir/style/

fetcher --url="https://github.com/GeoOSM/backend_nodejs/tree/master/python_script/style_default"
cp ./style_default/*.qml $geosm_dir$db/style/
rm -r style_default

jq --arg path_backend $path_backend --arg db $db --arg user_bd $user_bd --arg pass_bd $pass_bd --arg port_bd $port_bd --arg destination_style $geosm_dir$db/style/ --arg destination $geosm_dir$db/gpkg/ '.projet[$db] = {"destination_style":$destination_style,"destination":$destination,"database":$db,"user":$user_bd,"password":$pass_bd,"port":$port_bd,"path_backend":$path_backend}'  ${list_projet} |sponge  ${list_projet}
echo "Fichier de configuration pour NODE js crée"

jq -n --arg rootApp $path_backend --arg urlNodejs $urlNodejs_backend"importation" --arg urlNodejs_backend $urlNodejs_backend --arg projet_qgis_server $db '{"rootApp":$rootApp,"urlNodejs":$urlNodejs,"urlNodejs_backend":$urlNodejs_backend,"projet_qgis_server":$projet_qgis_server}' > $path_backend"public/assets/config.js"
sed  -i '1i var config_projet =' $path_backend"public/assets/config.js"

cp $path_backend".env.exemple" $path_backend".env"
sed -i 's/database_name/'${db}'/g' $path_backend".env"
sed -i 's/database_username/'${user_bd}'/g' $path_backend".env"
sed -i 's/database_password/'${pass_bd}'/g' $path_backend".env"

echo "Fichier de configuration pour laravel crée"


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

#étant root, si non il ecrira pas les log : forever start  -a --minUptime 5000  --spinSleepTime 5000 -l process.log -o out.log -e err.log server.js
# log de forver alors sont cat /root/.forever/process.log


#php artisan migrate

# 2a01:e0d:1:c:58bf
# @2a01:e0d:1:c:58bf:fac1:8000:167

# http://[2a01:e0d:1:c:58bf:fac1:8000:167]

# [2607:f0d0:1002:11::4:80] 
