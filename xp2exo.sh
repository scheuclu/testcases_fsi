#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

module load intel/intel-13

rm ./visualization/*.exo

$XP2EXO_EXECUTABLE ./mesh/runmesh/fluid_volume.top ./visualization/fluid_Solution.exo postpro/Pressure.xpost postpro/Mach.xpost postpro/Velocity.xpost postpro/Displacement.xpost

/home/pavery/bin/aeros -t structurefile.inp
$XP2EXO_EXECUTABLE ./structure_volume.top ./visualization/structure_Solution.exo results/strucure_volume.dis results/structure_volume.stress.vm

