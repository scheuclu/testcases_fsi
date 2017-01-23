#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

module load intel/intel-13

rm ./vis/*

for direction in plus minus; do
  $XP2EXO_EXECUTABLE ../../../mesh/runmesh/fluid_volume.top \
                     ./vis/fluid_Solution_steady_${direction}.exo \
                     postpro/Pressure_steady_${direction}.xpost \
                     postpro/Mach_steady_${direction}.xpost \
                     postpro/Velocity_steady_${direction}.xpost \
                     postpro/Displacement_steady_${direction}.xpost
done

#/home/pavery/bin/aeros -t structurefile_steady.inp
#$XP2EXO_EXECUTABLE ./structure_volume.top \
                   ##./visualization/coupled/structure_Solution_steady.exo \
                   ##results/coupled/strucure_volume_steady.dis \
                   ##results/coupled/structure_volume_steady.stress.vm


