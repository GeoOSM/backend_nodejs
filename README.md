# Projet Python + Node JS GeOsm

## Pré requis
Avant de continuer, vous devez avoir installé:
- Qgis server >= 3
- Qgis Python
- Node JS
- OGR2OGR et GDAL

## Installation
Le bon fonctionnement de GeOsm nécessite le respect des étapes suivantes..

##### 1. Déploiement du projet Node JS

```sh
$ git clone https://github.com/GeoOSM/backend_nodejs
$ cd ./backend_nodejs
$ npm install
```
##### 2. Modification du projet Node JS

Editer le fichier config.js

| variable | valeur attendue |
| ------ | ------ |
| path_style_qml | empty path where we will store temporarely style files  |
| url_qgis_server | url de votre QGIS server sous la forme : http://xxx.xxx.xxx/cgi-bin/qgis_mapserv.fcgi?map= |
| url_node_js | url que vous donnerez à ce projet dans la partie 3 ci dessous (**www.backend_nodejs.geoosm**)|

Le projet Node JS est prèt ! 

##### 3. Configurer Apache ou Nginx pour associer un nom de domaine au projet node js
On appellera ce nom de domaine par la suite **www.backend_nodejs.geoosm**
##### 4. Créer votre  première instance geosm
Editer le fichier new_project_config.json :

| variable | valeur attendue |
| ------ | ------ |
| roi | path of the shapefile with the limit of your region of interest (1 feature in EPSG 4326) |
| path_pbf | link to the osm.pbf of your region of interest |
| urlNodejs_backend | link of backend geosm  (**www.backend_nodejs.geoosm**)  already install in your computer |
| path_projet | empty or not existing path where you want to deploy geosm in your computer |
| geosm_dir | empty or not existing path where you want to store geopackages files for qgis server to read them; This path can take multiple projects ! |
| db | name of database |
| user_bd | user of Database |
| pass_bd | password of Database |
| port_bd | port of Database  |

```sh
$ sudo chown -R postgres:postgres /var/www/
$ chmod +x ./create_project.sh
$ dos2unix ./create_project.sh
$ su - postgres
$ cd <relative path of create_project.sh>
$ ./create_project.sh
    # generer toutes les couches #
$ docker  exec -i -t geosm_carto   /home/keopx/boot_geosm_carto.sh
$ docker exec -ti geosm_carto npm run initialiser_projet --projet=<name of database of project>
    # Appliquer les styles par défaut à toutes les couches #
$ docker exec -ti geosm_carto npm run apply_style_projet --projet=<name of database of project>
```
##### 5. Configurer docker



###### Editer le fichier environment.ts et color.scss
Dans le dossier <path_projet>/docker/client/environments/

| variable | valeur attendue |
| ------ | ------ |
| url_prefix | url of administration (In local you can put http://localost:8060 to your file docker-compose.yml)  |
| url_frontend | url of portail (In local you can put http://localost:8070 according to your file docker-compose.yml ) |
| global_logo | empty or the path for the icon in https://github.com/GeoOSM/GeoOSM_Frontend/tree/dev/src/assets/images/Pays (eg. assets/images/Pays/ OUGANDA.svg) |
| drapeau | empty or path to a flag |
| nom | empy or the name of the project that will be show in the portail |
| indicatif_pays | indicatif of country for Nominatim search |
| primaryColor | color of portail (hex,rgb,rgba|
| default_language | fr or en |
| projetOsmCm | true or false |
Editer le fichier et color.scss avec la meme coucleur que celle mise à primaryColor

###### Editer le fichier docker-compose.yml
Dans le dossier <path_projet>
Nomer votre docker dans le fichier docker-compose.yml grâce à la variable **container_name**
Editer les ports:
- 8060 -> Pour l'administration
- 8070 -> Pour le portail 

###### construire l'image docker

```sh
$ cd <path_projet>/docker
$ docker-compose build
$ docker-compose up -d
$ docker  exec -i -t <container_name>   /var/www/boot.sh
```
