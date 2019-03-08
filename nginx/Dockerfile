FROM nginx
LABEL virtualhost=${VIRTUALHOST}

WORKDIR /etc/nginx/

# These proxy conf files all reference other
# containers in this docker-compose.
ADD proxy.d/*conf proxy.d/

# jinja2 templates are great but this loads in the entire build chain
#RUN apt-get update && apt-get install -y python-pip
#RUN pip install j2cli

# To add certificates to the image, uncomment these 3 lines
# and make sure your names are correct here.
#ADD fullchain.pem certs/ssl_cert.pem
#ADD privkey.pem certs/ssl_key.pem
#ADD dhparams.pem certs/dhparams.pem

WORKDIR /etc/nginx/conf.d/

# To enable TLS, you will need to uncomment the line that includes
# virtualhost_ssl.conf in this file.
ADD virtualhost.conf.j2 /etc/nginx/conf.d/

ADD virtualhost_ssl.conf /etc/nginx/snippets/

# NB that the envariables are expanded right here they
# don't need to be passed to the container in an ENV statement.
ARG VIRTUALHOST
ARG ACCESSPOLICY

# I wish I could justify using jinja2 here but it's bulky and sed is "free".
RUN rm -f /etc/nginx/conf.d/default.conf && \
    sed -e "s/{{ accesspolicy }}/${ACCESSPOLICY}/g" virtualhost.conf.j2 |\
    sed -e "s/{{ virtualhost }}/${VIRTUALHOST}/g" > virtualhost.conf

# Landing page
ADD index.html /var/www/html/
