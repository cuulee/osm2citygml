#!/usr/bin/env python

west=-97.6
east=-97.4
north=35.55
south=35.35
job_zoom=11

import mercantile,os

sw_tile=mercantile.tile(west,south,job_zoom)
ne_tile=mercantile.tile(east,north,job_zoom)

s_tile=sw_tile[1]
w_tile=sw_tile[0]
n_tile=ne_tile[1]
e_tile=ne_tile[0]

for y_tile in xrange(n_tile,s_tile+1):			# Flipped due to xyz vs tms counting of tiles
	for x_tile in xrange(w_tile,e_tile+1):
		bounds=mercantile.bounds(x_tile, y_tile, job_zoom)
		tile_bounds=[str(bounds[1]),str(bounds[0]),str(bounds[3]),str(bounds[2])]
		command="bash osm2citygml.sh "+" ".join(tile_bounds)+" "+"tile_"+"_".join(tile_bounds)
		os.system(command)
