# geoserver-compose
GeoServer + GeoWebCache + PostGIS + pgadmin + nginx all together in a Docker Compose setup.

This project uses docker-compose to orchestrate creation and startup of its containers.

For complete information on Geoserver, see http://geoserver.org/

## What is included

* GeoServer to serve spatial data in a wide variety of formats
* GeoWebCache to cache map tiles
* PostGIS/PostgreSQL to store data
* pgadmin to administer PostgreSQL
* nginx to act as a reverse proxy for everything and also it can serve static content

# How to run everything

## Prerequisites

You need to have working copies of docker and docker-compose.
So far I have only tested on Debian Stretch.

## The start up steps

1. Clone the project to a local folder.
2. 'cd' into the folder.
3. Copy dotenv-sample to .env and edit it. It has passwords and hostname and stuff like that in it.
4. Type "docker-compose up -d"

2019-03-07 It probably won't work for you, because I only released it today. :-) 
So tell me what happened, and I'll fix it. Things will go faster for you that way.

### SSL sort of works

Initially I set this project up to support SSL certificates but I've
decided not to worry about them. The way I implemented it was by
setting the certificates up on the proxy. This almost works but it
made the GeoServer layer preview feature fail. I have spent too much
time chasing down how to fix it (and similar problems caused by
proxies) so I've deactivated it for now.

If you want to try it anyway (for instance you don't care about layer
preview), copy your SSL certificates into the nginx/ directory and
uncomment the relevant lines in the nginx/Dockerfile and
nginx/virtualhost.conf.j2; it should be pretty obvious.

The certificates I used during testing were created by
certbot and live here as installed on the host:
````
/etc/letsencrypt/live/maps.wildsong.biz/fullchain.pem
/etc/letsencrypt/live/maps.wildsong.biz/privkey.pem
/etc/ssl/dhparams.pem
````
My certificates are not checked into github for obvious reasons.

### CORS

I put the configuration to generate the right HTTP headers to avoid
Cross Origin Scripting (CORS) error messages into the nginx proxy, see
nginx/proxy.d/geoserver.conf It seems to be working with Chrome and
Firefox on Windows.

### GeoWebCache

Just because there is a geowebcache server does not mean it will
do anything. Once everything is running, go into the geoserver
web interface, go to "TileCaching"->"Caching Defaults", turn on
"Enable direct integration".. and click "Save".

Once you do that when you hit the server with a WMS request,
you will need to add "tiled=true" to the URL for it to work.

