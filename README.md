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

I use a separate project, at home I use swag.  At work I use this
project https://github.com:brian32768/docker-proxy.git
It works quite well, including full support for
Let's Encrypt certificates.

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
So far I have only tested on Debian.

## The start up steps

1. Clone the project to a local folder.
2. 'cd' into the folder.
3. Copy sample.env to .env and edit it. It has settings for hosts and passwords, etc.
4. Type "docker-compose up -d"

Then this command should bring everything up

    docker-compose up

### BUG and WORKAROUND

At the current release my PostgreSQL container needs a bit of help. After the first start up I shut it down then went into the
volume geoserver-postgis-data and edited files by hand. in postgresql.conf add the line

    listen_addresses = '*'

and at the end of pg_hba.conf add

    host trust all all all

Then restart (docker-compose up). If you don't do this then postgresql will be shut up in its container refusing to talk to
the other containers.

When I run a separate copy of Postgres on the host I add this to the pg_hba.conf file.

   host    all             postgres        172.0.0.0/8             md5        # for pgadmin4 access
   host    gis_data        gis_owner       172.0.0.0/8             md5
   host    gis_data        gis_owner       192.168.123.0/24        md5
   local   gis_data        gis_owner                               md5

## GeoWebCache

You have to add a setting to make GeoWebCache start working.
Once the dockers are all running, go into the geoserver
web interface, go to "TileCaching"->"Caching Defaults", turn on
"Enable direct integration" and click "Save".

Once that is done, when your client hits the server with a WMS
request, you will need to add "tiled=true" to the URL for it to use
caching.

## Connecting

The URls to connect to your new servers are

   https://geoserver.yourdomain.com/geoserver
   https://geoserver.yourdomain.com/geowebcache
   https://pgadmin.yourdomain.com/

For pgadmin, use user "postgres" and the password you set in the .env file.
For Geoserver/Geowebcache, use admin and geoserver.

### What's the admin password?

Geoserver used to have a default of "root" and "geoserver". They don't do
that anymore. Start up the container and dump out the initial
password with this command.

```bash
docker exec geoserver cat /geoserver/security/masterpw.info
This file was created at 2021/06/05 16:40:14

The generated master password is: ,~oLl5E&

Test the master password by logging in as user "root"

This file should be removed after reading !!!.
```

## Loading data

I have a script here to load data "import_data.sh".
Before I can run it I have to create the user gis_owner and the database gis_data,
and schema clatsop which are owned by gis_owner. I do that in pgadmin4

## Lost Geoserver password recovery

Overwrite the file, restart, thusly:

```bash
docker exec geoserver cat /geoserver/security/masterpw.digest
docker container cp masterpw.digest geoserver:/geoserver/security
docker exec geoserver cat /geoserver/security/masterpw.digest
docker-compose restart
```
