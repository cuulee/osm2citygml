import requests,sys

# See http://stackoverflow.com/questions/14114729/save-a-large-file-using-the-python-requests-library

s=sys.argv[1]
w=sys.argv[2]
n=sys.argv[3]
e=sys.argv[4]

folder=sys.argv[5]

data = 'data=(way('+s+'%2C'+w+'%2C'+n+'%2C'+e+')%5B%22building%22%5D%3Bway('+s+'%2C'+w+'%2C'+n+'%2C'+e+')%5B%22building%3Apart%22%5D%3B)%3B(._%3B%3E%3B)%3Bout+meta%3B'

with open (folder+'/osm.xml', 'w') as handle:
	response=requests.get('https://overpass-api.de/api/interpreter', data=data, stream=True)
	for block in response.iter_content(1024):
		handle.write(block)
