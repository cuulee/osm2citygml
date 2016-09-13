#!/bin/bash
WAY=$1

time curl "https://overpass-api.de/api/interpreter" --data "data=(%0Arel(40.69728274017714%2C-74.01924848556519%2C40.71876991146138%2C-74.00184631347656)%5B%22type%22%3D%22building%22%5D%3B%0Away(40.69728274017714%2C-74.01924848556519%2C40.71876991146138%2C-74.00184631347656)%5B%22building%22%5D%3B%0Away(40.69728274017714%2C-74.01924848556519%2C40.71876991146138%2C-74.00184631347656)%5B%22building%3Apart%22%5D%3B%0A)%3B%0A(._%3B%3E%3B)%3B%0Aout+meta%3B" > $WAY.xml
time ./osm2world.sh --input $WAY.xml --output $WAY.obj
time /opt/fme-desktop-2016/fme osm2citygml.fmw  --SourceDataset_OBJ $WAY.obj --DestDataset_CITYGML $WAY.gml

