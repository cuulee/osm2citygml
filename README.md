# osm2citygml
This tool will take single buildings from OSM using Overpass and convert it to CItyGML format with FME for eventual use with 3DCityDB

To use on Ubuntu:

1. Install FME
2. Download OSM2World from http://osm2world.org/download/files/latest/OSM2World-latest-bin.zip, and extract.
3. Copy osm2citygml.fmw and osm2citygml.sh to the OSM2World-latest directory
4. Run "bash osm2citygml.sh 67172260" where 67172260 is the way number for a building.
5. You will have a 67172260.gml file appear in the same directory which is the CityGML representation of the way: 67172260 building projected into 3D using OSM2World

What's not working:

1. Correct coords, all CityGML files are in the coordinates converted into by OSM2World.
2. Deal with complex buildings + parts. This tool only currently works with buildings, not building parts and the combined representation of all those building parts.
3. This has not been tested in 3DCityDB yet.
4. Textures aren't handled
5. Terrain heights I don't think are handled.
