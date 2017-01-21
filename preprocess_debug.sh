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

module load intel/intel-13

rm ./data/*

## Decompose fluid mesh
#  Creates./mesh/runmesh/fluid_volume.top.dec.12
$PARTNMESH_EXECUTABLE ./mesh/runmesh/fluid_volume.top 2
printSuccess "Fluid mesh decomposed"

## Run Matcher
$MATCHER_EXECUTABLE ./mesh/runmesh/fluid_volume.top ./matcher.inp -output ./mesh/matcher/MATCHEROUTPUT_debug
printSuccess "Matcher completed"

## Run Sower to pre-process the fluid mesh
$SOWER_EXECUTABLE -fluid -mesh ./mesh/runmesh/fluid_volume.top -match ./mesh/matcher/MATCHEROUTPUT_debug.match.fluid -dec ./mesh/runmesh/fluid_volume.top.dec.2 -cpu 2 -output ./mesh/sower/fluid_sowered_debug
printSuccess "Sower completed"

