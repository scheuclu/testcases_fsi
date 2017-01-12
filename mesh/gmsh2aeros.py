#!/usr/bin/python3

import sys
print("                     _     ___                             ")
print("                    | |   |__ \                            ")
print("  __ _ _ __ ___  ___| |__    ) |__ _  ___ _ __ ___  ___    ")
print(" / _` | '_ ` _ \/ __| '_ \  / // _` |/ _ \ '__/ _ \/ __|   ")
print("| (_| | | | | | \__ \ | | |/ /| (_| |  __/ | | (_) \__ \   ")
print(" \__, |_| |_| |_|___/_| |_|____\__,_|\___|_|  \___/|___/   ")
print("  __/ |                                                    ")
print(" |___/                                                     ")

if len(sys.argv)!=3:
   error("Syntax: gmsh2aeros.py <msh-file> <outfile>")

print("\033[92mSyntax valid\033[00m")

mshfile=sys.argv[1]
outfile=sys.argv[2]


with open(mshfile) as f:
    t=f.read()

nodearray=t[t.find('Nodes')+6:t.find('EndNodes')-1].splitlines()[1:]
for i in range(0,len(nodearray)):
    nodearray[i]=str(i+1)+" "+nodearray[i].split(' ',1)[1]+"\n"

print("\033[93m"+str(len(nodearray))+" nodes created\033[00m")

elearray=t[t.find('Elements')+9:t.find('EndElements')-1].splitlines()[1:]
eleindex=1
elearray_out=[]
indices_tet=[]
indices_tri=[]
for i in range(0,len(elearray)):
    elementtype=int(elearray[i].split(' ')[1])
    if elementtype==4: #volume elements
        linesplit=elearray[i].split()
        nodes=linesplit[-4:]
        elearray_out.append(str(eleindex)+" 23 "+nodes[0]+" "+nodes[1]+" "+nodes[2]+" "+nodes[3]+"\n")
        indices_tet.append(eleindex)
        eleindex=eleindex+1
    if elementtype==2: #triangle surface elements
        linesplit=elearray[i].split()
        nodes=linesplit[-3:]
        elearray_out.append(str(eleindex)+" 129 "+nodes[0]+" "+nodes[1]+" "+nodes[2]+"\n")
        indices_tri.append(eleindex)
        eleindex=eleindex+1


print("\033[93m"+str(len(elearray_out))+" elements created\033[00m")


#############################################
# Writing the output                        #
#############################################
with open(outfile+".nodes.aerosmsh",'w') as f:
    f.write("*\nNODES\n")
    f.writelines(nodearray)
    print("\033[93mNodes written\033[00m")


    f.write("*\nTOPOLOGY\n")
    f.writelines(elearray_out)
    print("\033[93mTOPOLOGY written\033[00m")

with open(outfile+".attributes.aerosmsh","w") as f:
    f.write("*\nATTRIBUTES\n")
    for index in indices_tet:
      f.write(str(index)+" 1\n")
    for index in indices_tri:
      f.write(str(index)+" -1\n")
    print("\033[93mATTRIBUTES written\033[00m")

    f.write("*\nMATERIAL\n")
    f.write("1 0 608000000.000000 0.400000 1153.400000 0 0 0.000076 0 0 0 0 0 0 0\n")
    print("\033[93mMATERIAL written\033[00m")

    # f.write("*\nMATUSAGE\n")
    # f.write("1 "+str(len(elearray_out))+" 1\n")
    # print("\033[93mMATUSAGE written\033[00m")

    # f.write("*\nMATLAW\n")
    # f.write("1 HyperElasticPlaneStress 1153.400000 608000000.000000 0.400000 0.000076\n")
    # print("\033[93mMATLAW written\033[00m")

print("\033[92mAERO-S mesh files created\033[00m")
