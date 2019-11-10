all:	build

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

# After you do "make build" you can run these test commands to test the postgis server by itself

test-db-nodata:
	docker run -it --rm --name=pgis geoserver_db bash

test-db:
	docker run -it --rm --name=pgis -v geoserver_postgis_data:/var/lib/postgresql/data geoserver_db bash

