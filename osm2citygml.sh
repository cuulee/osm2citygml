#!/bin/bash

S=$1
W=$2
N=$3
E=$4

FOLDER=$5

echo '########################################################################################'
echo $FOLDER
mkdir $FOLDER
echo '*********************************'
echo 'Getting Data'
python overpass.py $S $W $N $E $FOLDER
echo '*********************************'
echo 'Converting to OBJ'
./osm2world.sh --input $FOLDER/osm.xml --output $FOLDER/tile.obj
echo '*********************************'
echo 'Getting center of OBJ, it is being saved as .obj.loc'
cat $FOLDER/tile.obj | grep '#' | grep Coordinate  | cut -d " " -f 6,8 | tr "," " " | tr -s " " > $FOLDER/tile.obj.loc
echo '*********************************'
echo 'Rotating OBJ'
/opt/fme-desktop-2016/fme objflip.fmw --SourceDataset_OBJ $FOLDER/tile.obj --DestDataset_OBJ $FOLDER/rot_tile
mv $FOLDER/rot_tile/test.obj $FOLDER/rot_tile.obj
echo '*********************************'
echo 'Recentering OBJ into EPSG:3857 coords'
python obj3857.py $FOLDER/rot_tile.obj $FOLDER/tile.obj.loc $FOLDER/3857_rot_tile.obj
echo '*********************************'
echo 'Converting to CityGML'
cd $FOLDER
/opt/fme-desktop-2016/fme ../osm2citygml.fmw --SourceDataset_OBJ 3857_rot_tile.obj --DestDataset_CITYGML $FOLDER.gml
