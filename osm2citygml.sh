#!/bin/bash
NAME=$1

rm $NAME.xml $NAME.gml $NAME.obj $NAME.obj.mtl 3857_$NAME.obj
echo '*********************************'
echo 'Getting Data'
time curl "http://overpass-api.de/api/interpreter" --data "data=(%0Away(40.7028951229916%2C-74.01718854904173%2C40.711922746583795%2C-74.00669574737549)%5B%22building%22%5D%3B%0Away(40.7028951229916%2C-74.01718854904173%2C40.711922746583795%2C-74.00669574737549)%5B%22building%3Apart%22%5D%3B%0A)%3B%0A(._%3B%3E%3B)%3B%0Aout+meta%3B%0A++%0A" > $NAME.xml
echo '*********************************'
echo 'Converting to OBJ'
time ./osm2world.sh --input $NAME.xml --output $NAME.obj
echo '*********************************'
echo 'Getting center of OBJ, it is being saved as .obj.loc'
cat test.obj | grep '#' | grep Coordinate  | cut -d " " -f 6,8 | tr "," " " | tr -s " " > $NAME.obj.loc
echo '*********************************'
echo 'Rotating OBJ'
time /opt/fme-desktop-2016/fme objflip.fmw --SourceDataset_OBJ $NAME.obj --DestDataset_OBJ rot_$NAME
mv rot_$NAME/$NAME.obj rot_$NAME.obj
rm -r rot_$NAME
echo '*********************************'
echo 'Recentering OBJ into EPSG:3857 coords'
time python obj3857.py rot_$NAME.obj $NAME.obj.loc
echo '*********************************'
echo 'Converting to CityGML'
time /opt/fme-desktop-2016/fme osm2citygml.fmw --SourceDataset_OBJ 3857_rot_$NAME.obj --DestDataset_CITYGML $NAME.gml
