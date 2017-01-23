#!/bin/bash

############################################################
# Define Variables                                         #
############################################################
function printSuccess() {
  RED='\033[1;31m'
  NC='\033[0m'
  printf "${RED}$1${NC}\n\n"
}

SOWER_EXECUTABLE=/home/pavery/bin/sower
MATCHER_EXECUTABLE=/home/pavery/bin/matcher
PARTNMESH_EXECUTABLE=/home/pavery/bin/partnmesh
XP2EXO=/home/pavery/bin/xp2exo
SDESIGN_EXECUTABLE=/home/lscheuch/codes/sdesign.d/Executables.d/sdesign.Linux.opt

module load intel/intel-13

rm ./data/*

## Decompose fluid mesh
#  Creates./mesh/runmesh/fluid_volume.top.dec.12
rm ./mesh/runmesh/fluid_volume.top.dec.12
$PARTNMESH_EXECUTABLE ./mesh/runmesh/fluid_volume.top 12
printSuccess "Fluid mesh decomposed"

## Create Distance to Wall file
/home/pavery/bin/cd2tet -mesh ./mesh/runmesh/fluid_volume.top -output ./mesh/runmesh/fluid_volume
printSuccess "Distance to wall file created"

## Run Matcher
$MATCHER_EXECUTABLE ./mesh/runmesh/fluid_volume.top ./matcher.inp -output ./mesh/matcher/MATCHEROUTPUT
printSuccess "Matcher completed"


#run SDesign
cd ./sdesign
$SDESIGN_EXECUTABLE structure_volume.sdesign
printSuccess "SDesign finished. Check if all nodes have been inside the volume"

#Sower the result files of sdesign
#Is there really a need to do this? I am running the structure on one core only anyway
#$SOWER_EXEC -struct \
            #-mesh ../mesh/mesh_ref.msh \
            #-split -con ../../mesh/mesh_ref.con \
            #-result naca.der \
            #-bc -3 \
            #-ascii -out structure_volume.der

#$SOWER_EXEC -struct \
            #-mesh ../../mesh/mesh_ref.msh \
            #-split -con ../../mesh/mesh_ref.con \
            #-result naca.vmo \
            #-bc -3 \
            #-ascii -out structure_volume.vmo

#printSuccess "SOWER on SDesign output finished"
cd ..

## Run Sower to pre-process the fluid mesh
$SOWER_EXECUTABLE -fluid -mesh ./mesh/runmesh/fluid_volume.top -match ./mesh/matcher/MATCHEROUTPUT.match.fluid -dec ./mesh/runmesh/fluid_volume.top.dec.12 -cpu 12 -output ./mesh/sower/fluid_sowered
printSuccess "Sower on .top-file completed"

#$SOWER_EXECUTABLE -fluid -fluid -split -mesh ./mesh/sower/fluid_sowered.msh -con ./mesh/sower/fluid_sowered.con -result ./mesh/runmesh/fluid_volume.dwall -ascii -output ./mesh/sower/fluid_sowered.dwall
#printSuccess "Sower on .dwall file completed"

## Create .exo-files from meshes
$XP2EXO ./mesh/premsh/structure_fluid_interface.top ./mesh/exo/structure_fluid_interface.exo
$XP2EXO ./mesh/runmesh/fluid_volume.top ./mesh/exo/fluid_volume.exo
printSuccess "mesh filed converted to exodus format"

