ACCOUNTNAME="gis_owner"
DATABASE="gis_data"
HOSTNAME="172.24.0.3"



#docker exec geoserver-db psql -U ${ACCOUNTNAME} ${DATABASE}

SRC_PROJ="EPSG:2913"
DEST_PROJ="EPSG:3857"

cd /green/GIS/Data_Repository/OR/Clatsop/lisdata

SHAPEFILE=ccparks
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=${HOSTNAME} user=${ACCOUNTNAME} password=${GIS_PASSWORD} dbname=${DATABASE}" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln parks

SHAPEFILE=roads
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=${HOSTNAME} user=${ACCOUNTNAME} password=${GIS_PASSWORD} dbname=${DATABASE}" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTILINESTRING \
	 -nln roads

SHAPEFILE=ccbound
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=${HOSTNAME} user=${ACCOUNTNAME} password=${GIS_PASSWORD} dbname=${DATABASE}" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln county_boundary 

SHAPEFILE=watpoly
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=${HOSTNAME} user=${ACCOUNTNAME} password=${GIS_PASSWORD} dbname=${DATABASE}" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln water_poly

cd taxlot_accounts
SHAPEFILE=taxlots_accounts
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=${HOSTNAME} user=${ACCOUNTNAME} password=${GIS_PASSWORD} dbname=${DATABASE}" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln taxlots
