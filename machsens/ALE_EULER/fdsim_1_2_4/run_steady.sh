#!/bin/bash

#PBS -N fdsim_1_2_4_ALE_Euler
#PBS -M lscheuch@stanford.edu
#PBS -l nodes=1:ppn=12
#PBS -l walltime=48:00:00

CURRENT_DIR='/home/lscheuch/project/testcases_fsi/machsens/ALE_EULER/sim_1_2_4'

function printSuccess() {
   RED='\033[1;31m'
   NC='\033[0m'
   printf "${RED}$1${NC}\n\n"
}

module load openmpi/openmpi161_intel13

#AEROF_EXEC=/home/lscheuch/codes/aero-f_build/bin/aerof.opt
AEROF_EXEC=/home/pavery/bin/aerof.opt
AEROS_EXEC=/home/pavery/bin/aeros
SOWER_EXEC=/home/mzahr/frg_codes/sower/bin/sower.Linux
XP2EXO_EXEC=/home/pavery/bin/xp2exo
SDESIGN_EXEC=/home/lscheuch/codes/sdesign.d/Executables.d/sdesign.Linux.opt

cd $CURRENT_DIR

cmd_plus="mpirun -np 12 $AEROF_EXEC fluidfile_steady_plus.inp : -np 1 $AEROS_EXEC structurefile_steady.inp"
cmd_minus="mpirun -np 12 $AEROF_EXEC fluidfile_steady_minus.inp : -np 1 $AEROS_EXEC structurefile_steady.inp"

$cmd_plus >& $CURRENT_DIR/log_steady_plus.log

$cmd_minus >& $CURRENT_DIR/log_steady_minus.log

printSuccess AEROF_ENDED

#cd results
#$SOWER_EXEC -fluid -merge -con ../../mesh/mesh_ref.con -mesh ../../mesh/mesh_ref.msh -result naca_steady.pres -output naca_steady_pressure
#$SOWER_EXEC -fluid -merge -con ../../mesh/mesh_ref.con -mesh ../../mesh/mesh_ref.msh -result naca_steady.sol -output naca_steady_sol
#$SOWER_EXEC -fluid -merge -con ../../mesh/mesh_ref.con -mesh ../../mesh/mesh_ref.msh -result naca_steady.disp -output naca_steady_disp
#$XP2EXO_EXEC ../../mesh/naca.top naca_steady.exo naca_steady_pressure.xpost naca_steady_sol.xpost naca_steady_disp.xpost
#printSuccess POSTPROCESSING_ENDED
#cd ..

