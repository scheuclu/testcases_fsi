#!/usr/bin/python3

import sys

if len(sys.argv)!=3:
   error("Syntax: gmsh2sdesignnodes.py <msh-file> <outfile>")

print("\033[92mSyntax valid\033[00m")

mshfile=sys.argv[1]
outfile=sys.argv[2]


with open(mshfile) as f:
    t=f.read()

nodearray=t[t.find('Nodes')+6:t.find('EndNodes')-1].splitlines()[1:]
for i in range(0,len(nodearray)):
    nodearray[i]=str(i+1)+" "+nodearray[i].split(' ',1)[1]+"\n"

print("\033[93m"+str(len(nodearray))+" nodes created\033[00m")


#############################################
# Writing the output                        #
#############################################
with open(outfile,'w') as f:
    f.write("FENODES\n")
    f.writelines(nodearray)
    f.write("END\n")


print("\033[92mAERO-S mesh files created\033[00m")
