#!/usr/bin/python3

import numpy as np
import os
from shutil import copyfile #for file copy command

copyfile('meshgen/structure_volume_template.geo','meshgen/structure_volume.geo')
copyfile('meshgen/structure_fluid_interface_template.geo','meshgen/structure_fluid_interface.geo')
copyfile('meshgen/fluid_volume_template.geo','meshgen/fluid_volume.geo')

stringmeshsize=""
stringmsizefarfield="1.0"
thickness="-0.01"  #default:-0.01
size_farfield="6.0"; #radius of the far-field

data=np.genfromtxt('meshgen/nacanodes.txt', dtype=None, delimiter=',', skip_header=0)

numnodes=data.shape[0]

#Create an appropriate string array in gmsh syntax
nodecreatestring=""
lineliststr=""
for i in range(0,numnodes):
    nodecreatestring+="Point("+str(i+1)+") = {"+str(data[i][0])+","+str(data[i][1])+","+str(data[i][2])+stringmeshsize+"};\n"
    # linelistst+=str(i+1);


with open('meshgen/structure_volume.geo','r') as f:
    outtext=f.read().replace('<nacanodes>',nodecreatestring)
    outtext=outtext.replace('<numnodes>',str(numnodes))
    outtext=outtext.replace('<linelist>',str(range(1,numnodes)))
    outtext=outtext.replace('<thickness>',thickness)
with open('meshgen/./structure_volume.geo','w') as f:
    f.write(outtext)

#replace placeholders with stringcontents
with open('meshgen/structure_fluid_interface.geo','r') as f:
    outtext=f.read().replace('<nacanodes>',nodecreatestring)
    outtext=outtext.replace('<numnodes>',str(numnodes))
    outtext=outtext.replace('<linelist>',str(range(1,numnodes)))
    outtext=outtext.replace('<thickness>',thickness)
with open('meshgen/structure_fluid_interface.geo','w') as f:
    f.write(outtext)

#replace placeholders with stringcontents
with open('./meshgen/fluid_volume.geo','r') as f:
    outtext=f.read().replace('<nacanodes>',nodecreatestring)
    outtext=outtext.replace('<numnodes>',str(numnodes))
    outtext=outtext.replace('<linelist>',str(range(1,numnodes)))
    outtext=outtext.replace('<msizefarfield>',stringmsizefarfield)
    outtext=outtext.replace('<thickness>',thickness)
    outtext=outtext.replace('<size_farfield>',size_farfield)
with open('./meshgen/fluid_volume.geo','w') as f:
    f.write(outtext)



