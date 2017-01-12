#!/bin/bash

function printSuccess() {
  RED='\033[1;31m'
  NC='\033[0m'
  printf "${RED}$1${NC}\n\n"
}

SOWER_EXECUTABLE=/home/pavery/bin/sower
MATCHER_EXECUTABLE=/home/pavery/bin/matcher
PARTNMESH_EXECUTABLE=/home/pavery/bin/partnmesh

module load intel/intel-13

rm ./data/*

# Decompose fluid mesh
# Creates./mesh/runmesh/fluid_volume.top.dec.12
rm ./mesh/runmesh/fluid_volume.top.dec.12
$PARTNMESH_EXECUTABLE ./mesh/runmesh/fluid_volume.top 12
printSuccess "Fluid mesh decomposed"

# Run Matcher
$MATCHER_EXECUTABLE ./mesh/runmesh/fluid_volume.top ./matcher.inp -output ./mesh/matcher/MATCHEROUTPUT
printSuccess "Matcher completed"

# Run Sower to pre-process the fluid mesh
$SOWER_EXECUTABLE -fluid -mesh ./mesh/runmesh/fluid_volume.top -match ./mesh/matcher/MATCHEROUTPUT.match.fluid -dec ./mesh/runmesh/fluid_volume.top.dec.12 -cpu 12 -output ./mesh/sower/fluid_sowered
printSuccess "Sower completed"


