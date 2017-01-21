#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

module load intel/intel-13

rm ./visualization/*_unsteady.exo

$XP2EXO_EXECUTABLE ./mesh/runmesh/fluid_volume_unsteady.top ./visualization/fluid_Solution_unsteady.exo postpro/Pressure_unsteady.xpost postpro/Mach_unsteady.xpost postpro/Velocity_unsteady.xpost postpro/Displacement_unsteady.xpost

/home/pavery/bin/aeros -t structurefile_unsteady.inp
$XP2EXO_EXECUTABLE ./structure_volume.top ./visualization/structure_Solution_unsteady.exo results/strucure_volume_unsteady.dis results/structure_volume_unsteady.stress.vm

