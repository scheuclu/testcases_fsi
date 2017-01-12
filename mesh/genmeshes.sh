#######################################################################
# Creates all necessary meshed for the FSI ALE simulation             #
#                                                                     #
# At the end of this script you should have the following meshfiles:  #
#    -) ./runmesh/structure_volume.aerosmsh                           #
#    -) ./premsh/structure_fluid_interface.top                        #
#    -) ./premsh/fluid_volume.top                                     #
#######################################################################

function printSuccess() {
  RED='\033[1;31m'
  NC='\033[0m'
  printf "${RED}$1${NC}\n\n"
}

#create consistent .geo files
#all will share the same nach geometry and will have the same pseudo-thickness
python3.5 ./gengeofiles.py
printSuccess "created .geo-files"
sleep 2s
clear

#remove old meshes
rm ./meshgen/structure_volume.msh
rm ./meshgen/structure_fluid_interface.msh
rm ./meshgen/fluid_volume.msh
rm ./premsh/*
rm ./runmesh/*
printSuccess "deleted old mesh files"
sleep 2s
clear

#Create a structure mesh for AERO-S using nas2fem
gmsh ./meshgen/structure_volume.geo -3 -o ./premsh/structure_volume.bdf
gmsh ./meshgen/structure_volume.geo -3 -o ./premsh/structure_volume.msh
./nas2fem ./premsh/structure_volume.bdf -o ./runmesh/structure_volume.aerosmsh 
printSuccess "strucure_volume mesh created"
sleep 2s
clear

#create fluid mesh as .top file
gmsh ./meshgen/structure_fluid_interface.geo -2 -o ./premsh/structure_fluid_interface.msh
./gmsh2top ./premsh/structure_fluid_interface
mv ./premsh/structure_fluid_interface.top ./runmes/structure_fluid_interface.top
printSuccess "strucure_fluid_interface mesh created"
sleep 2s
clear

#create interface mesh as .topfile
gmsh ./meshgen/fluid_volume.geo -3 -o ./premsh/fluid_volume.msh
./gmsh2top ./premsh/fluid_volume
#SymmetrySurface needs a tag to label it a Sliding Surface
sed -i -- 's/SymmetrySurface/SymmetrySurface_8/g' ./premsh/fluid_volume.top
mv ./premsh/fluid_volume.top ./runmesh/fluid_volume.top
printSuccess "fluid_volume mesh created"
sleep 2s
clear

#create a mesh-file suitable for aeros
./gmsh2aeros.py ./premsh/structure_volume.msh ./runmesh/structure_volume_alt
printSuccess "structure_colume_alt mesh created"
sleep 2s
