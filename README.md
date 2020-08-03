# Projet Python + Node JS GeOsm

## Pré requis

Installer les pré-recquis de requiements.md

## Installation

Le bon fonctionnement de GeOsm nécessite le respect des étapes suivantes..

##### 1. Déploiement du projet Node JS

```sh
$ git clone https://github.com/GeoOSM/backend_nodejs
$ cd ./backend_nodejs/docker_geom_carto
$ docker-compose build --no-cache
$ docker-compose up -d
$ docker  exec -i -t geosm_carto  /home/keopx/boot_geosm_carto.sh
```
##### 2. Modification du projet Node JS

Editer le fichier config.js

| variable | valeur attendue |
| ------ | ------ |
| path_style_qml | empty path where we will store temporarely style files  |
| url_qgis_server | url de votre QGIS server sous la forme : http://xxx.xxx.xxx/ows/?map= |
| url_node_js | url que vous donnerez à ce projet dans la partie 3 ci dessous (**www.backend_nodejs.geoosm**)|

Le projet Node JS est prèt sur le port 8080 ! 

##### 3. Configurer Apache ou Nginx pour associer un nom de domaine au projet node js
On appellera ce nom de domaine par la suite **www.backend_nodejs.geoosm**

❌  NB : les fichiers projet.json et config.js ne doivent jamais ètre supprimés de ce dossier, même lors d'une mise à jour du dépot !

## Création des images DOCKER

```
$ cd docker_geosm
$ docker build --no-cache  -t geosm .
```
## Créer une instance geosm

##### 1. Editer le fichier backend_nodejs/new_project_config.json :

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

##### 2. Créer le projet :

```sh
$ sudo chown -R postgres:postgres /var/www/
$ chmod +x ./create_project.sh
$ dos2unix ./create_project.sh
$ su - postgres
$ ./create_project.sh

```

##### 3. Configurer docker pour l'administration et le portail public


###### Editer le fichier environment.ts et color.scss
Dans le dossier <path_projet>/docker/client/environments/ <path_projet> du new_project_config.json de l'étape 1:
- Editer le fichier environment.ts

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

- Editer le fichier color.scss avec la meme coucleur que celle mise à primaryColor

###### Pour le thème Ville,Editer le fichier .env
NB : Si vous faite le thème classique (pays), vous pouvez passer cette étape

Dans le dossier <path_projet>/docker/public/ <path_projet> du new_project_config.json de l'étape 1:
- Editer le fichier .env

| variable | valeur attendue |
| ------ | ------ |
| intersection | true |

###### Editer le fichier docker-compose.yml
Dans le dossier <path_projet>/

dans le fichier docker-compose.yml:

Modifier les valeurs:
- services_name : service_<nom_pays>
- container_name: geosm_<nom_pays>
Editer les ports:
- 8060 -> Pour l'administration
- 8070 -> Pour le portail

Seulement pour le thème ville:
- image: geosm_ville


###### construire l'image docker

```
$ chmod -R 777 <path_projet>/docker
$ cd <path_projet>/docker
$ docker-compose up -d
$ docker  exec -i -t ""container_name""   /var/www/boot.sh
```
##### 4. Créer les couches avec leurs styles par defaut :

```sh
    # generer toutes les couches #
$ docker exec -ti geosm_carto npm run initialiser_projet --projet=<name of database of project>
    # Appliquer les styles par défaut à toutes les couches #
$ docker exec -ti geosm_carto npm run apply_style_projet --projet=<name of database of project>
```

## Pour mettre à jour la BD OSM
```sh
# mettre à jour la BD (https://github.com/Magellium/magOSM/tree/master/database)

$ osmosis --read-replication-interval-init workingDirectory=/var/www/geosm/<name of database of project>/up-to-date
$ osmium fileinfo -e --progress -v /var/www/backend_nodejs/osm.pbf
$ nano /var/www/geosm/<name of database of project>/up-to-date/state.txt
    timestamp=osmosis_replication_timestamp - 24h (Ex 2020-04-28T20:59:03Z - 24h = 2020-04-27T20:59:03Z)
	sequenceNumber=osmosis_replication_sequence_number (Ex 2595)
$ nano /var/www/geosm/<name of database of project>/up-to-date/configuration.txt (le fichier existe déja normalement, il a été crée par la première commande avec osmosis)
    baseUrl=osmosis_replication_base_url (EX http://download.geofabrik.de/europe/france-updates)
    maxInterval=jours en secondes ( Pour une semaine : 7 * 24 * 3600 = 604800)
$ mkdir /var/www/geosm/<name of database of project>/up-to-date
$ mkdir /var/www/geosm/<name of database of project>/up-to-date/keepup-cron-logs/
$ chmod +x /var/www/geosm/<name of database of project>/up-to-date/update_osm_db.sh
$ cron tous les 5 jours à minuit : 0 0 */5 * *  /var/www/geosm/<name of database of project>/up-to-date/update_osm_db.sh > /var/www/geosm/france/up-to-date/keepup-cron-logs/keepup-cron.log 2>&1

```

## Existing replication 

* Cameroun ([GeoCameroun]( http://geoportail.geocameroun.cm/))
* Itasy (Region in Madagascar)  ([geoitasy beta]( http://geoitasy.com))
* France ([Data OSM](http://geosm.openstreetmap.fr/))

## Thanks

GEOSM is what it is because of some crazy people, company and free and open source projects. Let's name a few:
* Karl TAYOU : Main developer
* Willy Franck SOB : The energy he put through GeoCameroon which was the first GEOSM implementation. This helped to ameliorate the user interface and to the addition of some new awesome features
 * Anas LAGHRISSI
* Jean-Louis Zimmerman : For his implication which resulted in the definition of more than 300 layers
* SOGEFI CAMEROUN ([Website](http://sogefi.cm)): firstly, for the initial code system of the administrative panel, and for the beautiful design of the frontend ( Aka les CAURI)
* OpenStreetMap ([OSM](http://osm.org))
* Openlayers ([Website](http://openlayers.com))
* QGIS SERVER ([Website](https://docs.qgis.org/3.4/en/docs/training_manual/qgis_server/index.html))


