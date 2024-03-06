# geoserver-compose

GeoNode + GeoServer + GeoWebCache + PostGIS + pgadmin 
all working together in perfect harmony in a Docker Compose setup.

This project uses Docker Compose to orchestrate creation and startup
of its containers. It should work with Docker Swarm too, have not tested.

For complete information on Geoserver, see http://geoserver.org/

2024-03-05 GeoNode is coming. Getting it aligned with versions compatible with Geonode.
2023-07-20 I stopped using customized images for PostGIS and Geoserver today.

## What is included

* GeoNode as a content management service
* GeoServer to serve spatial data in a wide variety of formats
* GeoWebCache to cache map tiles
* Nginx web server
* PostGIS/PostgreSQL to store data including spatial data
* pgadmin to administer PostgreSQL

### Some plugins for GeoServer are installed

The extensions loaded are now controlled in the compose.yaml file,
look there. Make sure the one you need is there and not commented out.

* Vector tile service (integrated with GeoWebCache too)
* Excel (allows generating Excel files as WFS output)
* wps
* ogr-wfs
* ogr-wps

Adding the Excel plugin required adding the Apache Commons Compress JAR file.
See http://commons.apache.org/proper/commons-compress

The ogr-* plugins use the command line ogr* tools so the gdal-bin Debian
package is installed.

## How to run everything

### Prerequisites

You need to have working copies of docker and docker-compose.
So far I have only tested on Debian.

The pgadmin container runs as user 5050 so set the ownership on its folder accordingly. For example,

    chown -R 5050 /var/lib/docker/volumes/geoserver_pgadmin/_data

### The start up steps

1. Clone the project to a local folder.
2. 'cd' into the folder.
3. Copy sample.env to .env and edit it. It has settings for hosts and passwords, etc.
4. Type "docker compose up -d"
5. I had problems convincing it to start, I think the old files in the data folder needed to be removed.
6. Go to http://localhost:8080/geoserver
Log in with username: admin and password: geoserver

You can test out one component if you want, for example,

    docker compose up geoserver

nginx is running at http://localhost:8081/

pgadmin should be accessible at http://localhost:8082

postgis is running on port 5432 (This is the default for postgresql,
so you might have to change it at your site.)

I used the current setup with the ip address of the PostGIS server in pgadmin
which is 10.10.10.210, the username "postgres", and the password from .env file.

## GeoWebCache

You have to add a setting to make GeoWebCache start working.
Once the dockers are all running, go into the geoserver
web interface, go to "TileCaching"->"Caching Defaults", turn on
"Enable direct integration" and click "Save".

Once that is done, when your client hits the server with a WMS
request, you will need to add "tiled=true" to the URL for it to use
caching.

