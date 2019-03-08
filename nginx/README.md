# nginx container

The container gets built when you do

    docker-compose build

The primary purpose of this web server is to act as
a reverse proxy for the other geoserver-compose services.

It is configured to add the headers to geoserver responses to deal with CORS errors.

## Proxies

You can add more files to proxy.d.
As long as they end in ".conf", they will be added to the image by the Dockerfile.

## Static content

You can mount a static content directory if you want to serve additional content directly.
That's what I do in geoserver-compose.



