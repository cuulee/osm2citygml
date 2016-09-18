from pyproj import Proj, transform
import sys

input_file=sys.argv[1]
input_location=sys.argv[2]
output_file=sys.argv[3]

inProj=Proj(init='epsg:4326')
outProj=Proj(init='epsg:3857')

output_file = open(output_file,"w")

with open(input_location,"r") as location_file:
	for line in location_file:
		line_split=line.split(" ")
		origin_lat=float(line_split[0])
		origin_lon=float(line_split[1])
		origin_x,origin_y=transform(inProj,outProj,origin_lon,origin_lat)
location_file.close()

with open(input_file,"r") as obj_file:
	for line in obj_file:
		if "v " in line:
			vertex_line=line.split(" ")
			obj_x=float(vertex_line[1])
			obj_y=float(vertex_line[2])
			obj_z=float(vertex_line[3])
			obj_x=obj_x+origin_x
			obj_y=obj_y+origin_y
			output_file.write('v '+str(obj_x)+" "+str(obj_y)+" "+str(obj_z)+"\n")
		else:
			output_file.write(line)
output_file.close()
obj_file.close()
