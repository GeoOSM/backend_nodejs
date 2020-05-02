#!/bin/bash
# source : https://github.com/springmeyer/up-to-date/blob/master/how_to.txt

# make sure osmososis/osm2pgsql are on your PATH
# cron does not inherit from your env
export PATH=/usr/bin/:$PATH
DBNAME=france
DBUSER=postgres
HOST='localhost'
DIR=/var/www/geosm/france/up-to-date
STYLE_FILES=/var/www/backend_nodejs/BD/default.style
# lock file
LOCK=$DIR/keepup.lock

cd $DIR

if [ -f $LOCK ]; then
  if [ "$(ps -p `cat $LOCK` | wc -l)" -gt 1 ]; then
	echo "Locked"
	exit 1
  else
	rm $LOCK
  fi
fi
echo $$ >$LOCK
OSM_CHANGE=diffs/latest.osc.gz
rm $OSM_CHANGE
osmosis --read-replication-interval workingDirectory=. --simplify-change  --write-xml-change $OSM_CHANGE
osm2pgsql --append -H $HOST -U $DBUSER -d $DBNAME --slim --cache 10000 --number-processes 5 --extra-attributes --hstore-all  -G --style $STYLE_FILES  $OSM_CHANGE
rm $LOCK
