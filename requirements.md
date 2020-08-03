Pour Debian 10 (Buster)

```sh
$ sudo apt-get install wget gdal-bin zip jq curl moreutils dos2unix
```
# QGIS Server

On utilise le docker de 3liz/py-qgis-server :https://github.com/3liz/py-qgis-server/tree/master/docker

```sh
$ docker run -p 8080:8080 \
       -v /path/to/qgis/projects:/projects \
       -e QGSRV_SERVER_WORKERS=2 \
       -e QGSRV_LOGGING_LEVEL=DEBUG  \
       -e QGSRV_CACHE_ROOTDIR=/projects \
       -e QGSRV_CACHE_SIZE=10 \
       3liz/qgis-map-server
```

# Node js 11
```sh
$ curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs
```

# PostgreSQL & Postgis 
```sh
$ RELEASE=$(lsb_release -cs)
$ echo "deb http://apt.postgresql.org/pub/repos/apt/ ${RELEASE}"-pgdg main | sudo tee  /etc/apt/sources.list.d/pgdg.list
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get -y install postgresql-11 postgresql-client-11 postgresql-11-postgis-3
```

# osm2pgsql latest

```sh
$ sudo apt-get install git make cmake g++ libboost-dev libboost-system-dev libboost-filesystem-dev libexpat1-dev zlib1g-dev libbz2-dev libpq-dev libproj-dev lua5.2 liblua5.2-dev
$ git clone git://github.com/openstreetmap/osm2pgsql.git
$ cd osm2pgsql
$ mkdir build && cd build
$ cmake ..
$ make
$ sudo make install
$ cd ../../
$ rm -rf osm2pgsql
```

# Docker 

```sh
$ sudo apt-get update

$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

# Docker compose

```sh
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

# osmosis

```sh
$ apt-get install osmosis
$ export JAVACMD_OPTIONS=-Xmx5G
```