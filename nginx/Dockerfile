FROM nginx

WORKDIR /etc/nginx/

# These proxy conf files all reference other
# containers in this docker-compose.
ADD proxy.d/*conf proxy.d/

ARG virtualhost
LABEL virtualhost=${virtualhost}

# To add SSL certificates to the image, uncomment these 3 lines
# and make sure your names are correct here.
#ADD fullchain.pem certs/ssl_cert.pem
#ADD privkey.pem certs/ssl_key.pem
#ADD dhparams.pem certs/dhparams.pem

WORKDIR /etc/nginx/conf.d/

# To enable SSL, you will need to uncomment the line that includes
# virtualhost_ssl.conf in this file.
ADD virtualhost.conf.j2 /etc/nginx/conf.d/

ADD virtualhost_ssl.conf /etc/nginx/snippets/

# If I need more flexibility I can switch to using jinja2 templates
#RUN pip install j2cli

# NB that the envariable is expanded right here so
# it does not need to be passed to the container in an ENV statement.

RUN rm -f /etc/nginx/conf.d/default.conf && \
    /bin/sed "s/{{ virtualhost }}/${virtualhost}/" < virtualhost.conf.j2 > virtualhost.conf

# Static content
VOLUME /var/www/html/

# Landing page
ADD index.html /var/www/html/

