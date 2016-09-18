# osm2citygml
This tool will take XMLs of buildings from OSM using Overpass and convert it to CityGML format with OSM2World and FME for eventual use with 3DCityDB

![Screenshot](screenshot-cesium.png "Screenshot")

To use on Ubuntu:

1. Install FME
2. Download OSM2World from http://osm2world.org/download/files/latest/OSM2World-latest-bin.zip, and extract.
3. Copy all files from this repository to the OSM2World-latest directory
4. Edit the first 5 lines of main.py to contain the bounding box you'd like. I strongly suggest that you change in overpass.py the Overpass URL to a local one or only do small extracts! 
5. Run "python main.py".
5. In each "tile_*" directory, you will have a file with extension .gml. You can copy these to one location and then import to 3DCityDB
