# geoserver-compose
GeoServer + GeoWebCache + PostGIS + pgadmin all working together
in perfect harmony in a Docker Compose setup.

This project uses docker-compose to orchestrate creation and startup
of its containers.

For complete information on Geoserver, see http://geoserver.org/

## What is included

* GeoServer to serve spatial data in a wide variety of formats
* GeoWebCache to cache map tiles
* A web server to serve static content, for example JavaScript apps
* PostGIS/PostgreSQL to store data
* PL/python3 procedural language
* pgadmin to administer PostgreSQL

### Reverse proxy no longer included

I used to include nginx in this bundle as a reverse proxy but I moved
it to a separate project because I needed to proxy other dockers on the same server,
so now the proxy is separate from geoserver. It's called docker-proxy
and it's in a github repository. It's at
https://github.com:brian32768/docker-proxy.git It works quite well,
including full support for Let's Encrypt certificates.

### Some extra plugins for GeoServer are installed

* Vector tile service (integrated with GeoWebCache too)
* Excel (allows generating Excel files as WFS output)
* wps
* ogr-wfs
* ogr-wps
* scripting (allows installing python scripts on the GeoServer)

Adding the Excel plugin required adding the Apache Commons Compress JAR file.
See http://commons.apache.org/proper/commons-compress

The ogr-* plugins use the command line ogr* tools so the gdal-bin Debian
package is installed.

# How to run everything

## Prerequisites

You need to have working copies of docker and docker-compose.
So far I have only tested on Debian Stretch.

## The start up steps

1. Clone the project to a local folder.
2. 'cd' into the folder.
3. Copy sample.env to .env and edit it. It has settings for hosts and passwords, etc.
4. Type "docker-compose up -d"

## GeoWebCache

Just because there is a geowebcache server does not mean it will
do anything. Once everything is running, go into the geoserver
web interface, go to "TileCaching"->"Caching Defaults", turn on
"Enable direct integration".. and click "Save".

Once you do that when you hit the server with a WMS request,
you will need to add "tiled=true" to the URL for it to work.

