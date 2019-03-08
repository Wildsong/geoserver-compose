cd /green/GIS/Data_Repository/OR/Clatsop/lisdata

#docker exec geoserver-db psql -U gis_owner gis_data

SRC_PROJ="EPSG:2913"
DEST_PROJ="EPSG:3857"

SHAPEFILE=ccparks
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=localhost user=gis_owner dbname=gis_data" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop_wm -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln parks

SHAPEFILE=roads
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=localhost user=gis_owner dbname=gis_data" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop_wm -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTILINESTRING \
	 -nln roads

SHAPEFILE=ccbound
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=localhost user=gis_owner dbname=gis_data" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop_wm -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln county_boundary 

SHAPEFILE=watpoly
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=localhost user=gis_owner dbname=gis_data" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop_wm -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln water_poly

SHAPEFILE=accts
ogr2ogr -skipfailures -t_srs "EPSG:3857" -f PostgreSQL \
	 PG:"host=localhost user=gis_owner dbname=gis_data" \
         $SHAPEFILE.shp $SHAPEFILE \
	 -lco GEOMETRY_NAME=geom -lco SCHEMA=clatsop_wm -lco OVERWRITE=YES -lco PRECISION=NO \
	 -nlt MULTIPOLYGON \
	 -nln taxlots
