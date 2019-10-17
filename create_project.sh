#!/bin/bash
db="mali"
roi="/var/www/GeoOSM_Backend/mali.shp"
path_pbf="http://download.geofabrik.de/africa/mali-latest.osm.pbf"
geosm_dir='/var/www/geosm/'
urlNodejs_backend='http://service.geocameroun.cm/'
path_backend="/var/www/GeoOSM_Backend/projet_laravel/"

list_projet='./projet.json'
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
ogr2ogr -f "PostgreSQL" PG:"host=localhost user=postgres dbname=$db password=postgres"  $roi -nln temp_table -lco GEOMETRY_NAME=geom
psql -d $db -c "UPDATE instances_gc SET geom = st_transform(limite.geom,4326), true_geom = st_transform(limite.geom,4326) FROM (SELECT * from temp_table limit 1) as limite WHERE instances_gc.id = 1;"
psql -d $db -c "TRUNCATE temp_table;"

mkdir -m 777 -p $geosm_dir$db/gpkg/
mkdir -m 777 -p $geosm_dir$db/style/

fetcher --url="https://github.com/GeoOSM/backend_nodejs/tree/master/python_script/style_default"
cp ./style_default/*.qml $geosm_dir$db/style/
rm -r style_default

jq --arg db $db --arg destination_style $geosm_dir$db/style/ --arg destination $geosm_dir$db/gpkg/ '.projet[$db] = {"destination_style":$destination_style,"destination":$destination,"database":$db}'  ${list_projet} |sponge  ${list_projet}
echo "Fichier de configuration pour NODE js crée"

jq -n --arg rootApp $path_backend --arg urlNodejs $urlNodejs_backend"importation" --arg urlNodejs_backend $urlNodejs_backend --arg projet_qgis_server $db '{"rootApp":$rootApp,"urlNodejs":$urlNodejs,"urlNodejs_backend":$urlNodejs_backend,"projet_qgis_server":$projet_qgis_server}' > $path_backend"public/assets/config.js"
sed  -i '1i var config_projet =' $path_backend"public/assets/config.js"

sed -i 's/database_name/'${db}'/g' $path_backend".env"
sed -i 's/database_username/postgres/g' $path_backend".env"
sed -i 's/database_password/postgres/g' $path_backend".env"

echo "Fichier de configuration pour laravel crée"


echo "termne !!!!! !!! !"
exit


# sudo apt-get install php7.3-xml
# sudo apt-get install php-mbstring
# composer install
# sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
# sudo apt-get install gdal-bin

#vim /etc/apt/sources.list
# deb     https://qgis.org/debian buster main
# deb-src https://qgis.org/debian buster main
# wget -O - https://qgis.org/downloads/qgis-2019.gpg.key | gpg --import
# gpg --fingerprint 51F523511C7028C3
# gpg --export --armor 51F523511C7028C3 | sudo apt-key add -
# apt install qgis-server
#mkdir -m 777 -p /var/www/geosm/
#apt-get install jq
#  apt-get install moreutils
#npm install -g github-files-fetcher
#npm run initialiser_projet --projet=mali
# 2a01:e0d:1:c:58bf
# @2a01:e0d:1:c:58bf:fac1:8000:167

# http://[2a01:e0d:1:c:58bf:fac1:8000:167]

# [2607:f0d0:1002:11::4:80]