# geoserver-compose
GeoServer + GeoWebCache + PostGIS + pgadmin + nginx all together in a Docker Compose setup.

This project uses docker-compose to orchestrate creation and startup of its containers.

For complete information on Geoserver, see http://geoserver.org/

# What runs here

* geoserver to serve data in a variety of formats
* geowebcache to cache map tiles
* postgis/postgresql to store data
* pgadmin to administer postgresql
* nginx to act as a proxy and also it can serve static content

## Settings

Copy dotenv-sample to .env and then edit it to specify site-specific information including passwords and hostname.

### SSL

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

## Run everything

This command starts nginx, postgis, geoserver, geowebcache, and pgadmin4

    docker-compose up -d

It uses the config file docker-compose.yml to set all this up.

## Master password

There will be a master password stashed away in the Tomcat containers
(for geoserver and geowebcache). I used to have information here on
how to find it, but I don't think it's that important anymore. Google
it.

## Sample GeoServer data issue 

If you use a volume you won't be able to access the GeoServer sample
data with this container, it will be in the wrong place, I used to
have complicated instructions here on how to fix this, but I don't
care about the sample data anymore. Just use your own.

