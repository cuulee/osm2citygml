#!/bin/bash
WAY=$1

time curl "https://overpass-api.de/api/interpreter" --data "data=way($WAY)[building];(._;>;);out meta;" > $WAY.xml
time ./osm2world.sh --input $WAY.xml --output $WAY.obj
time /opt/fme-desktop-2016/fme osm2citygml.fmw  --SourceDataset_OBJ $WAY.obj --DestDataset_CITYGML $WAY.gml

# To do:
# Correct coords
# Deal with complex buildings + parts (select all ways that are contained withing a building way?)
# test in 3dcitydb
# speed up!
# terrain height
