#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

module load intel/intel-13

rm ./visualization/*_steady.exo

$XP2EXO_EXECUTABLE ./mesh/runmesh/fluid_volume.top \
                   ./visualization/coupled/fluid_Solution_steady.exo \
                   postpro/coupled/Pressure_steady.xpost \
                   postpro/coupled/Mach_steady.xpost \
                   postpro/coupled/Velocity_steady.xpost \
                   postpro/coupled/Displacement_steady.xpost

/home/pavery/bin/aeros -t structurefile_steady.inp
$XP2EXO_EXECUTABLE ./structure_volume.top \
                   ./visualization/coupled/structure_Solution_steady.exo \
                   results/coupled/strucure_volume_steady.dis \
                   results/coupled/structure_volume_steady.stress.vm


