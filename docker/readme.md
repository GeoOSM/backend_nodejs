
wget http://test.geocameroun.xyz/geosm.zip
docker load -i geosm.zip
cd /dir
configurer tous les fichier qu'il faut

docker-compose up -d
docker  exec -i -t  backend_partie  /var/www/boot.sh