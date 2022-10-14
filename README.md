# geoserver-compose
GeoServer + GeoWebCache + PostGIS + pgadmin all working together
in perfect harmony in a Docker Compose setup.

This project uses docker-compose to orchestrate creation and startup
of its containers.

For complete information on Geoserver, see http://geoserver.org/

**NOTE 2022-10-14 RIGHT NOW TODAY I AM ONLY TESTING GEOSERVER (docker-compose up geoserver)**

**NOTE -- Don't "upgrade" from Tomcat:9 in Dockerfile.tomcat -- it won't work! Trust me.**

## What is included

* GeoServer to serve spatial data in a wide variety of formats
* GeoWebCache to cache map tiles
* A web server to serve static content, for example JavaScript apps
* PostGIS/PostgreSQL to store data
* PL/python3 procedural language
* pgadmin to administer PostgreSQL

I used to include an Nginx-based proxy in this bundle, now I use a separate one, based on Caddy.

### Some plugins for GeoServer are installed

* Vector tile service (integrated with GeoWebCache too)
* Excel (allows generating Excel files as WFS output)
* wps
* ogr-wfs
* ogr-wps
* SOLR extension, to support free text searches
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

You have to add a setting to make GeoWebCache start working.
Once the dockers are all running, go into the geoserver
web interface, go to "TileCaching"->"Caching Defaults", turn on
"Enable direct integration" and click "Save".

Once that is done, when your client hits the server with a WMS
request, you will need to add "tiled=true" to the URL for it to use
caching.

